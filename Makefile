# variables
CC=gcc
CFLAGS=-Wall -Wextra
BUILD_DIR=build
SRC_DIR=src

# list of source files
PROGRAMS = touch mmkdir

# building binaries from src
BINARIES = $(addprefix $(BUILD_DIR)/, $(addsuffix .exe, $(PROGRAMS)))
SOURCES = $(addprefix $(SRC_DIR)/, $(addsuffix .c, $(PROGRAMS)))

# target
all: $(BINARIES)

# build rule
$(BUILD_DIR)/%.exe: $(SRC_DIR)/%.c
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $< -o $@

# clean
clean:
	rm -rf $(BUILD_DIR)