ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
TOOLS_DIR := $(ROOT_DIR)/tools
RANDOM_PRIME_DIR := $(ROOT_DIR)/randomprime

CARGO := cd $(RANDOM_PRIME_DIR) && cargo

.PHONY: requirements submodules clean build all randomprime_debug randomprime_release run run_debug run_release

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

$(RANDOM_PRIME_DIR)/target/debug/randomprime_patcher : randomprime_debug
randomprime_debug :
	@echo "Building $@..."
	@$(CARGO) build

$(RANDOM_PRIME_DIR)/target/release/randomprime_patcher : randomprime_release
randomprime_release :
	@echo "Building $@..."
	@$(CARGO) build --release

run_debug : $(RANDOM_PRIME_DIR)/target/debug/randomprime_patcher
	@echo "Running patcher cli (debug)..."
	@RUST_BACKTRACE=1 $(RANDOM_PRIME_DIR)/target/debug/randomprime_patcher --profile $(ROOT_DIR)/world_layout.json

run_release : $(RANDOM_PRIME_DIR)/target/release/randomprime_patcher
	@echo "Running patcher cli..."
	@$(RANDOM_PRIME_DIR)/target/release/randomprime_patcher --profile $(ROOT_DIR)/world_layout.json
