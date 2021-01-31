ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SRC_DIR := $(ROOT_DIR)/src
TOOLS_DIR := $(ROOT_DIR)/tools
BUILD_DIR := $(ROOT_DIR)/build
RANDOM_PRIME_DIR := $(ROOT_DIR)/randomprime

CARGO := cd $(RANDOM_PRIME_DIR) && cargo

CC := $(shell which gcc)

CFLAGS := -I$(SRC_DIR)/include
CFLAGS += -I$(SRC_DIR)/thirdparty/cJSON

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
	@rm -rf $(BUILD_DIR)
	@make $(BUILD_DIR)

tote : $(BUILD_DIR)/tote

$(BUILD_DIR) :
	@mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/tote : $(BUILD_DIR)
	$(CC) -o $(BUILD_DIR)/tote $(SRC_DIR)/tote.c $(SRC_DIR)/thirdparty/cJSON/cJSON.o $(CFLAGS)

build : submodules
	@echo "Building..."
	@$(CARGO) build --release
