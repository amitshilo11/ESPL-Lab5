#include <stdio.h>

extern int open(char *src);
extern int close(int file_des);

int main(int argc, char **argv) {

	if (argc != 2) {
		fprintf(stderr, "Usage: %s <src file>\n", argv[0]);
		return 0;
	}

	// open the file
	int file_descriptor = open(argv[1]);
	/*
	if(file_descriptor < 0) {
		fprintf(stderr, "%s\n", "ERROR: can't open the file");
		return 0;
	}
	*/
	fprintf(stderr, "%s%d\n", "The corresponding file descriptor is ", file_descriptor);

	// close the file
	int ans = close(file_descriptor);
	if(ans!=0)
		fprintf(stderr, "%s%d\n", "can't close the file, ERROR: ", ans);

	fprintf(stderr, "%s\n", "CLOSING DONE");
	return 0;
}