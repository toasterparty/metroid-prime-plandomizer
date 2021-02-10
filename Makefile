ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
TOOLS_DIR := $(ROOT_DIR)/tools
RANDOM_PRIME_DIR := $(ROOT_DIR)/randomprime
RELEASE_DIR := $(ROOT_DIR)/release

CARGO := cd $(RANDOM_PRIME_DIR) && cargo

ifeq ($(OS),Windows_NT) # is Windows_NT on XP, 2000, 7, Vista, 10...
    detected_OS := Windows
else
    detected_OS := $(shell uname)  # same as "uname -s"
endif

.PHONY: requirements submodules clean build all randomprime_debug randomprime_release run_debug run_release release

all : | submodules randomprime_debug randomprime_release

requirements :
	@sudo apt-get install cmake -y
	@sudo apt-get install expect -y
	@sudo apt-get install g++-powerpc-linux-gnu -y
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	@$(ROOT_DIR)/tools/expect.sh "source $(HOME)/.cargo/env && exit"
	@rustup target add --toolchain stable powerpc-unknown-linux-gnu

submodules :
	@git submodule update --init --recursive

clean :
	@echo "Cleaning..."
	@$(CARGO) clean
	@rm -f $(ROOT_DIR)/prime_out.iso
	@rm -rf $(RELEASE_DIR)

$(RANDOM_PRIME_DIR)/target/debug/randomprime_patcher : randomprime_debug
randomprime_debug : submodules
	@echo "Building $@..."
	@$(CARGO) build

$(RANDOM_PRIME_DIR)/target/release/randomprime_patcher : randomprime_release
randomprime_release : submodules
	@echo "Building $@..."
	@$(CARGO) build --release

run_debug : $(RANDOM_PRIME_DIR)/target/debug/randomprime_patcher
	@echo "Running patcher cli (debug)..."
	@RUST_BACKTRACE=1 $(RANDOM_PRIME_DIR)/target/debug/randomprime_patcher --profile $(ROOT_DIR)/world_layout.json

run_release : $(RANDOM_PRIME_DIR)/target/release/randomprime_patcher
	@echo "Running patcher cli..."
	@$(RANDOM_PRIME_DIR)/target/release/randomprime_patcher --profile $(ROOT_DIR)/world_layout.json

RELEASE_DIR_TEMP := $(RELEASE_DIR)/metroid-prime-plandomizer
release : $(RANDOM_PRIME_DIR)/target/release/randomprime_patcher
	@echo "Packaging release for Unix..."
	@rm -rf $(RELEASE_DIR)
	@mkdir -p $(RELEASE_DIR)
	@mkdir -p $(RELEASE_DIR_TEMP)
	@cp $(RANDOM_PRIME_DIR)/target/release/randomprime_patcher $(RELEASE_DIR_TEMP)/plandomizer_patcher
	@cp -r $(ROOT_DIR)/plandos $(RELEASE_DIR_TEMP)
	@cp $(TOOLS_DIR)/patch.sh $(RELEASE_DIR_TEMP)
	@cp $(ROOT_DIR)/README.md $(RELEASE_DIR_TEMP)
	@cd $(RELEASE_DIR) && tar -czf metroid-prime-plandomizer.tar.gz metroid-prime-plandomizer
