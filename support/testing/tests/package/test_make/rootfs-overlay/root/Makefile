MESSAGE ?= "Hello Buildroot!"
COUNT ?= 10

LIST = $(shell seq $(COUNT))
INPUTS = $(addsuffix .in.txt,$(LIST))
OUTPUT = output.txt

.PHONY: all
all: $(OUTPUT)

.PHONY: clean
clean:
	$(RM) $(OUTPUT) *.in.txt

.PHONY: message
message:
	@echo $(MESSAGE)

%.in.txt:
	echo $(subst .in.txt,,$@) > $@

$(OUTPUT): $(INPUTS)
	(cat $? | tr -d '\n' ; echo) > $@
