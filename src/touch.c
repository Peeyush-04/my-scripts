#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <windows.h>

#define setColorGreen(handleName) SetConsoleTextAttribute(handleName, FOREGROUND_GREEN | FOREGROUND_INTENSITY)
#define setColorWhite(handleName) SetConsoleTextAttribute(handleName, FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY)

int main(int argc, char *argv[]) {
  // color change logic
  // get handle from STD_HANDLE_OUTPUT
  HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

  // creating files
  printf("\n=> ");
  // color => green
  setColorGreen(hConsole);
  printf("Executing...\n");
  setColorWhite(hConsole);
  
  for(int i = 1; i < argc; i++) {
    int fd = open(argv[i], O_CREAT | O_WRONLY, 0644);
    
    // file descriptor error
    if(fd == -1) {
      perror(argv[i]);
      continue; // forward
    }

    close(fd);

    printf("=> ");
    // set color to green
    setColorGreen(hConsole);
    printf("Created:");
    setColorWhite(hConsole);
    printf(" %s\n", argv[i]);
  }
  printf("\n");

  // successful message
  printf("Program Executed successfully!\n");
  return 0; // no issues
}