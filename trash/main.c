#include <stdio.h>

extern int open(char *src);
extern int close(int file_des);
extern char* utoa_s(int number);

int main(int argc, char **argv) {

	int num = 123;
	fprintf(stderr, "%s%d\n", "num is: ", num);
	char* str = utoa_s(num);
	fprintf(stderr, "%s%s\n", "str is: ", str);

	return 0;
}