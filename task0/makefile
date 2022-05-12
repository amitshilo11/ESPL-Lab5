all: exe

asm-libs: open.s close.s
	nasm -f elf32 open.s -o open.o
	nasm -f elf32 close.s -o close.o

c-libs: main.c
	gcc -g -m32 -c main.c -o main.o

exe: asm-libs c-libs
	gcc -g -m32 -o start main.o open.o close.o
	rm -f main.o open.o close.o

	
clean:
	rm -f *.o start