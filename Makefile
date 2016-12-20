#
# Copyright (c) 2016 Mike Maraya <mike[dot]maraya[at]gmail[dot]com>
#
# This file is subject to the terms and conditions defined in
# https://github.com/mmaraya/patchstat/blob/master/LICENSE,
# which is part of this software package.
#

SHELL     := /bin/sh
PROGRAM   := patchstat
SRC_DIR   := src
OBJ_DIR   := obj
BIN_DIR   := bin
INC_DIR   := include
CPP_FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(addprefix $(OBJ_DIR)/,$(notdir $(CPP_FILES:.cpp=.o)))
LIB_FILES := 
CXX_FLAGS := -g -Wall -std=c++11 -I$(INC_DIR)
LD_FLAGS  := 

.PHONY: all clean

all: $(BIN_DIR)/$(PROGRAM)

$(BIN_DIR)/$(PROGRAM): $(OBJ_FILES)
	@mkdir -p $(@D)
	$(CXX) $(LD_FLAGS) -o $@ $^ $(LIB_FILES)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXX_FLAGS) -c -o $@ $<

clean:
	rm -f $(BIN_DIR)/$(PROGRAM) $(OBJ_DIR)/*.o
