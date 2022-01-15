#!/bin/bash

#controls loop
valid=true 
#ceaser function takes a message and will
#either decrypt or encrypt depending on user choice
function ceaser ()
{
#array of letters to simply help with the translate aspect 
#this will give the exact letter so for example, if the 
#user wanted 5 shifts, the letter that would be thrown into translate
#would be E array[element-1]
letters=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
echo "1 to encrypt, 2 to decrypt (Enter your choice): "
read choice
#encryption 
if [ $choice -eq 1 ]
then
echo "How many shifts: "
read shifts
#letterLow and Low2 will help translate messages with capital and lowercase
#this simply holds the character of a lowercase letter version of the shift value
#which is normally capital due to the array using capital letters
letterLow=$(echo "${letters[shifts-1]}" | tr A-Z a-z) 
letterLow2=$(echo "${letters[shifts-2]}" | tr A-Z a-z)
#translation aka encryption. Will obtain the capital leter for shift via referencing shift value - 1 up to Z and
#letter a up until letters[index-2]
secret=$(echo "$1" | tr "[A-Za-z]" "[${letters[shifts-1]}-ZA-${letters[shifts-2]}${letterLow}-za-${letterLow2}]")
#resets the shift value
shifts=0
#prints shift to screen
echo "Shifted $secret"
#decrypt
elif [ $choice -eq 2 ]
then
echo "Give me the encryption key: "
read shifts
#shifts the message back to the original message so long as the original shift value was 
#given
unsecret=$(echo "$secret" | tr "[${letters[shifts-1]}-ZA-${letters[shifts-2]}${letterLow}-za-${letterLow2}]" "[A-Za-z]")
echo "Unshifted: $unsecret"
fi
}
#ROT13 encryption
function j13 ()
{
echo "1 to encrypt, 2 to decrypt (Enter your choice): "
read choice
if [ $choice -eq 1 ]
then
secret=$(echo "$1" | tr "[A-Za-z]" "[N-ZA-Ln-za-l]") #translate from N-Z and A-L
echo "Shifted 13: $secret"
elif [ $choice -eq 2 ]
then
unsecret=$(echo "$secret" | tr "[N-ZA-Ln-za-l]" "[A-Za-z]") #shifts backwards
echo "Unshifted 13: $unsecret"
fi
}
#menu loop
while [ $valid ]
do
#menu options
echo "1) Use Ceaser cipher"
echo "2) Use ROT13 cipher"
echo "3) Read Message From File"
echo "4) Enter a message" 
echo "5) Save message to file"
echo "6) Exit"
echo "Enter your choice: "
read choice 

#cc choice passes in the message 
if [ $choice -eq 1 ]
then
ceaser "$message"
#rot13 option passes in message
elif [ $choice -eq 2 ]
then
j13 "$message"
#reads a files contents and puts it into message
elif [ $choice -eq 3 ]
then 
echo "Enter file name or dir: "
read fileName
message=$(<"$fileName")
#manual entry of a message
elif [ $choice -eq 4 ]
then
echo "Enter a message: "
read message
#saving message into a file
elif [ $choice -eq 5 ]
then
echo "Save file as: "
read fileName
echo "$message" > "$fileName"
#quit
elif [ $choice -eq 6 ]
then
valid=false
break
else
echo "Not recognized input
fi
done

