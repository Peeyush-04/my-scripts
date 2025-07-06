#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  // creating files
  printf("\nSuccessfully executed.\n");
  for(int i = 1; i < argc; i++) {
    int fd = open(argv[i], O_CREAT | O_WRONLY, 0644);
    
    // file descriptor error
    if(fd == -1) {
      perror(argv[i]);
      continue; // forward
    }

    close(fd);
    printf("Created: %s\n", argv[i]);
  }
  printf("\n");

  return 0; // no issues
}