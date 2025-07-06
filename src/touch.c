#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  if(argc > 2) {
    fprintf(stderr, "Usage: touch <file1>...");
    return 1; // argument issues
  }

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

  return 0; // no issues
}