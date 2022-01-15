#include <stdio.h>
#include <signal.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
int main(){
	const int size = 1000; //array size
	bool keepGoing = true; //menu loop value
	char userCommand[size]; //char arr with commands from shell
	char exitStr[5]; //str for word "exit"
	strcpy(exitStr, "exit"); //assign exitStr to "exit"
	int pid; //process id
	
	while(keepGoing == true){
		//shell prompt
		printf("~");
		scanf("%[^\n]%*c", userCommand); 
		
		if(strcmp (userCommand, exitStr) == 0){ //if userCommand is "exit" end the loop
			keepGoing = false;
		}
		
		char *arglist[size]; //arg list will have all tokens seperated
		int i = 0; //index for arglist
		arglist[i] = strtok(userCommand," "); //delimiter of a space
		while(arglist[i] != NULL){
			arglist[++i] = strtok(NULL, " "); //split the next token	
		}

		pid = fork(); //getting the process id
		if(pid == 0){ //execute the command if child process is 0
			execvp(arglist[0], arglist); //wait for child to end then loop again
		}else{
			wait(0); //waits for child process to end
		}
	
	}
	return 0;
}
