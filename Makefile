# compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra

# directories
BUILD_DIR = build
SRC_DIR = src

# list of programs
PROGRAMS = touch mmkdir

# build output
BINARIES = $(addprefix $(BUILD_DIR)/, $(addsuffix .exe, $(PROGRAMS)))
SOURCES  = $(addprefix $(SRC_DIR)/, $(addsuffix .c, $(PROGRAMS)))

# portable mkdir
ifeq ($(OS),Windows_NT)
	MKDIR_P = if not exist $(BUILD_DIR) mkdir $(BUILD_DIR)
	RM_RF   = rmdir /S /Q $(BUILD_DIR)
else
	MKDIR_P = mkdir -p $(BUILD_DIR)
	RM_RF   = rm -rf $(BUILD_DIR)
endif

# default target
all: $(BINARIES)

# build rule
$(BUILD_DIR)/%.exe: $(SRC_DIR)/%.c
	$(MKDIR_P)
	$(CC) $(CFLAGS) $< -o $@

# clean
clean:
	$(RM_RF)
