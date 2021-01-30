ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
TOOLS_DIR := $(ROOT_DIR)/tools
RANDOM_PRIME_DIR := $(ROOT_DIR)/randomprime
CARGO := cd $(RANDOM_PRIME_DIR) && cargo

.PHONY: requirements submodules clean build

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

build : submodules
	@echo "Building..."
	@$(CARGO) build --release
