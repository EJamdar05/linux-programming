# Linux Programming Class Samples
Some work done in my Linux class at CSUEB. Demonstration of shell and C syscall programming.
## Overview
* Basic Shell
This program demonstrates the use of a basic bash shell that takes user input and runs any Linux command given to it. The program is a basic loop that will open a new process up and execute the instance of the program until the prrgram is done executing and pass it back to the bash shell. 

* Caesar Cipher in C
This C program, when compiled, will take in command prompt arguments such as if the user wants to encreypt/decrypt, the number of shifts needed for the cipher and the file they want to read to shift. From there, the program will display the file either shifted or encyrpted. The file contents will then be written to the file. 
Example of decryption command
```
./ccipher 5 -r file.txt
```
Example of encyrption command
```
./ccipher 5 -s file.txt
```

* Caesar Cipher in Shell Script
This program is more of a traditional looping script that will take user input. The can choose to do a caesar cipher, do an ROT13 cipher (shifting chars 13), read in a file, save contents to a file or exit. Works similar to the previous program above except cipher is done by the translate command. 

## Running the Programs
Simply run the C programs using gcc
```
gcc -o namethis ./file.c
```

To run the shell script, make sure it is executable then run either line
```
./my_script.sh
```
```
bash my_script.sh
```
