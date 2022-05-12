%.o: %.s
	nasm -g -O1 -f elf -o $@ $<

all: exe

exe: start.o strlen.o main.o
	ld -melf_i386 -o $@ $^ -lc -I/lib/ld-linux.so.2
	rm -f start.o strlen.o prinf.o main.o

clean:
	rm -f *.o exe
