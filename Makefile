ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SRC_DIR := $(ROOT_DIR)/src
TOOLS_DIR := $(ROOT_DIR)/tools
BUILD_DIR := $(ROOT_DIR)/build
CJSON_DIR := $(ROOT_DIR)/src/thirdparty/cJSON
RANDOM_PRIME_DIR := $(ROOT_DIR)/randomprime

CARGO := cd $(RANDOM_PRIME_DIR) && cargo

CC := $(shell which gcc)
CXX := $(shell which c++)

INC := $(SRC_DIR)/include
INC += $(CJSON_DIR)
INC_PARAM := $(foreach d, $(INC), -I$d)

SRC := $(SRC_DIR)/tote.c

OBJ := $(CJSON_DIR)/cJSON.o

LIB_DIR := $(RANDOM_PRIME_DIR)/target/release
LIB_DIR_PARAM := $(foreach d, $(LIB_DIR), -L$d)

LIB := randomprime
LIB += stdc++
LIB += dl
LIB_PARAM := $(foreach d, $(LIB), -l$d)

CFLAGS := -pthread -shared -Wl,-export-dynamic
CFLAGS += $(LIB_DIR_PARAM)
CFLAGS += $(LIB_PARAM)
CFLAGS += $(INC_PARAM)

DEPS := $(SRC_DIR)/include/randomprime.h
DEPS += $(CJSON_DIR)/cJSON.h
DEPS += $(SRC)
DEPS += $(OBJ)
DEPS += $(RANDOM_PRIME_DIR)/target/release/librandomprime.a

.PHONY: requirements submodules clean build all cjson randomprime

all : submodules tote

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
	@cd $(CJSON_DIR) && make clean > /dev/null

cjson :
	@cd $(CJSON_DIR) && make all

tote : $(BUILD_DIR)/tote

$(BUILD_DIR) :
	@mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/tote : cjson $(BUILD_DIR) $(DEPS)
	$(CC) -o $@ $(SRC) $(OBJ) $(CFLAGS)

$(RANDOM_PRIME_DIR)/target/release/librandomprime.a : 
	@echo "Building $@..."
	@$(CARGO) build --release
