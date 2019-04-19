#!/bin/bash

LOWERCASE="abcdefghijklmnopqrstuvwxyz"
UPPERCASE="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
NUMBERS="0123456789"
SPECIAL_CHARACTERS="\~!@#\$%^&*()-_=+[{]}\\|;:'\",<.>/?"

if [[ $# -ne 5 ]]
then
	arg1="<allow_lowercase? 0 or 1>"
	arg2="<allow_uppercase? 0 or 1>"
	arg3="<allow_numbers? 0 or 1>"
	arg4="<allow_special_characters? 0 or 1>"
	arg5="<size? number>"
	echo "Usage: $0 $arg1 $arg2 $arg3 $arg4 $arg5"
	exit 1
fi

allow_lowercase=$1
allow_uppercase=$2
allow_numbers=$3
allow_special_characters=$4
size=$5

if [[ $allow_lowercase -ne 0 && $allow_lowercase -ne 1 ]]
then
	echo "Error: allow_lowercase must be 0 or 1"
	exit 1
fi

if [[ $allow_uppercase -ne 0 && $allow_uppercase -ne 1 ]]
then
        echo "Error: allow_uppercase must be 0 or 1"
        exit 1
fi

if [[ $allow_numbers -ne 0 && $allow_numbers -ne 1 ]]
then
        echo "Error: allow_numbers must be 0 or 1"
        exit 1
fi

if [[ $allow_special_characters -ne 0 && $allow_special_characters -ne 1 ]]
then   
        echo "Error: allow_special_characters must be 0 or 1"
        exit 1
fi

regex='^[0-9]+$'
if ! [[ $size =~ $regex ]]
then
	echo "Error: size must be a number"
	exit 1 
fi

if [[ $allow_lowercase -eq 0 && $allow_uppercase -eq 0 && $allow_numbers -eq 0 && $allow_special_characters -eq 0 ]]
then
	echo "Error: no characters are allowed... nothing can be generated"
	exit 1
fi

if [[ $size -lt 1 ]]
then
	echo "Error: size is less than 1... nothing can be generated"
	exit 1
fi

char_set=""

if [[ $allow_lowercase -eq 1 ]]
then
	char_set="${char_set}$LOWERCASE"
fi

if [[ $allow_uppercase -eq 1 ]]
then
	char_set="${char_set}$UPPERCASE"
fi

if [[ $allow_numbers -eq 1 ]]
then
	char_set="${char_set}$NUMBERS"
fi

if [[ $allow_special_characters -eq 1 ]]
then
	char_set="${char_set}$SPECIAL_CHARACTERS"
fi

char_set_length=${#char_set}

code=""

for i in `seq 1 $size`
do
	index=$(($RANDOM % $char_set_length))
	char=${char_set:$index:1}	
	code="$code$char"
done

echo "$code" | pbcopy

echo "Your clipboard now contains the randomly generated passcode"

exit 0

