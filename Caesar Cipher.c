#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>

int main (int argc, char *argv[])
{
	const int SIZE=1024;
	char temp = ' ';
	char encryptionChoice;
        int shift = atoi(argv[1]);
	int lineNum = 0,endLine = 0,tabReplace = 0,args = argc,num = 1,eolFlag=0,numRead=0,j=0,fd;
	char buf[SIZE];
	char c;

//CHECK FOR NO ARGS
	if(argc=0)
	{
		printf("Usage: %s -rs file.txt\n",argv[0]);
		exit(0);
	}
//PARSE ARGS FOR SWITCHES
	while(args--)
	{
		if(argv[args][0]=='-')
		{
			int switchLen=(int)strlen(argv[args]);
			while(switchLen--)
			{
				if(argv[args][switchLen]=='r')encryptionChoice = 'd';
				if(argv[args][switchLen]=='s')encryptionChoice = 'e';
			}
		}
	}	
//OPEN FILE
	fd = open( argv[argc-1], O_RDONLY );
	if ( fd == -1 )
	{
        	perror( argv[argc-1] ); 
        	exit(1);
	}
//READ FILE
	while((numRead=read(fd,buf,SIZE))>0)
	{
//PARSE BUFFER
	for(j=0;j<numRead;j++)
	{	c=buf[j];
		if(encryptionChoice == 'e'){
			if((c + shift > 'z') && (c >= 'a' && c <= 'z')){
			 	c-=26;
			 }else if ((c + shift > 'Z') && (c >= 'A' && c <= 'Z')){
			 	c-=26;
			 }
			 c+=shift;
		}else if (encryptionChoice == 'd'){
			if((c - shift > 'z') && (c >= 'a' && c <= 'z')){
			 	c+=26;
			 }else if ((c - shift > 'Z') && (c >= 'A' && c <= 'Z')){
			 	c+=26;
			 }
			 c-=shift;
		}
		if ((c >= 65 && c <= 90) || (c >= 97 && c <= 122)){
			printf("%c", c);
			}else if (c == 33){
				printf("%c",' ');
			}else if (c == 31){
				printf("%c",' ');
				}
			
			if(lineNum&&c=='\n')
			{
				eolFlag=1;
			}
			
	
	}
	}
//CLOSE FILE
	close(fd);
	printf("\n");
	return 0;
}
