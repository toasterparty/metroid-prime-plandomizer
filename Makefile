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

LIB := $(RANDOM_PRIME_DIR)/target/release/librandomprime.a
LIB += -lstdc++
LIB += -ldl

CFLAGS := -pthread -Wl,-export-dynamic -Wall -Wextra -pedantic
CFLAGS += $(LIB)
CFLAGS += $(INC_PARAM)

DEPS := $(SRC_DIR)/include/randomprime.h
DEPS += $(CJSON_DIR)/cJSON.h
DEPS += $(SRC)
DEPS += $(OBJ)
DEPS += $(RANDOM_PRIME_DIR)/target/release/librandomprime.a

.PHONY: requirements submodules clean build all cjson randomprime_debug randomprime_release run run_tote run_debug run_release

all : | submodules randomprime_debug

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
	$(CXX) -o $@ $(SRC) $(OBJ) $(CFLAGS)

$(RANDOM_PRIME_DIR)/target/debug/librandomprime.a : randomprime_debug
$(RANDOM_PRIME_DIR)/target/debug/randomprime_patcher : randomprime_debug
randomprime_debug :
	@echo "Building $@..."
	@$(CARGO) build

$(RANDOM_PRIME_DIR)/target/release/randomprime_patcher : randomprime_release
$(RANDOM_PRIME_DIR)/target/release/randomprime_patcher : randomprime_debug
randomprime_release :
	@echo "Building $@..."
	@$(CARGO) build --release

run_tote :
	@cd $(BUILD_DIR) && cp $(ROOT_DIR)/world_layout/doors.json . && ./tote

run : run_debug
run_debug : $(RANDOM_PRIME_DIR)/target/debug/randomprime_patcher
	@RUST_BACKTRACE=1 $(RANDOM_PRIME_DIR)/target/debug/randomprime_patcher --profile $(ROOT_DIR)/world_layout/doors-debug.json
