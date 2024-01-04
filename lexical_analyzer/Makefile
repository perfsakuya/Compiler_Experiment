CC=gcc
LEX=flex
RM=del

all: scanner

scanner: lex.yy.c
	$(CC) lex.yy.c -o scanner.exe

lex.yy.c: scanner.l
	$(LEX) scanner.l

clean:
	$(RM) -f lex.yy.c scanner.exe
