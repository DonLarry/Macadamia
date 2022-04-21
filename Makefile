TARGET = test

SRC = src
INC = inc
BIN = bin
TMP = tmp

SRCS = $(wildcard $(SRC)/*.cc $(TMP)/*.cc)
OBJS = $(patsubst %,$(BIN)/%, $(notdir $(SRCS:.cc=.o)))

CC = clang++
INCDIR = -I$(INC) -I$(TMP)
CFLAGS = -g -Wno-deprecated -Wall -pedantic $(INCDIR)


$(BIN)/$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

$(BIN)/%.o: $(TMP)/%.cc
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN)/%.o: $(SRC)/%.cc
	$(CC) $(CFLAGS) -c $< -o $@

configure: lexer.cc parser.tab.cc

lexer.cc:
	flex -o $(TMP)/lexer.cc lexer.l

parser.tab.cc:
	bison -b $(TMP)/parser parser.yy

debug:
	@echo "    CC: $(CC)"
	@echo "  SRCS: $(SRCS)"
	@echo "  OBJS: $(OBJS)"
	@echo "CFLAGS: $(CFLAGS)"

clean:
	rm -f $(BIN)/*
	rm -f $(TMP)/*

run:
	./$(BIN)/$(TARGET)
