all: lexer.cpp parser.tab.cc
	clang++ *.cpp parser.tab.cc -o test.exe

lexer.cpp:
	flex lexer.l

parser.tab.cc:
	bison parser.yy

clean:
	rm -f lexer.cpp
	rm -f location.hh
	rm -f parser.tab.cc
	rm -f parser.tab.hh
	rm -f position.hh
	rm -f stack.hh
	rm -f *.exe
