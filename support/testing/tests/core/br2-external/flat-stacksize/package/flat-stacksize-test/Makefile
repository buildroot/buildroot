O ?= $(CURDIR)

CANONICAL_O := $(shell mkdir -p $(O) >/dev/null 2>&1)$(realpath $(O))

TARGET := $(CANONICAL_O)/flat_stacksize_test

all: $(TARGET)

$(TARGET): main.c
	$(CC) $(CFLAGS) -o $@ main.c

clean:
	rm -f $(TARGET)

.PHONY: all clean
