ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SRC_DIR := $(ROOT_DIR)/src
TOOLS_DIR := $(ROOT_DIR)/tools
BUILD_DIR := $(ROOT_DIR)/build
RANDOM_PRIME_DIR := $(ROOT_DIR)/randomprime

CARGO := cd $(RANDOM_PRIME_DIR) && cargo

CC := $(shell which gcc)

INC := $(SRC_DIR)/include
INC += $(SRC_DIR)/thirdparty/cJSON

INC_PARAM =$(foreach d, $(INC), -I$d)

CFLAGS := $(INC_PARAM)

SRC := $(SRC_DIR)/tote.c

OBJ := $(SRC_DIR)/thirdparty/cJSON/cJSON.o

DEPS := $(SRC_DIR)/include/randomprime.h
DEPS += $(SRC_DIR)/thirdparty/cJSON/cJSON.h
DEPS += $(SRC)
DEPS += $(OBJ)

.PHONY: requirements submodules clean build all cjson randomprime

all : submodules tote randomprime

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
	@cd $(SRC_DIR)/thirdparty/cJSON && make clean > /dev/null

cjson :
	@cd $(SRC_DIR)/thirdparty/cJSON && make all

tote : $(BUILD_DIR)/tote

$(BUILD_DIR) :
	@mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/tote : $(BUILD_DIR) $(DEPS) cjson
	$(CC) -o $@ $(SRC) $(OBJ) $(CFLAGS)

randomprime : 
	@echo "Building..."
	@$(CARGO) build --release
