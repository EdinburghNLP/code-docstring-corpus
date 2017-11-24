#! /bin/sh

find $1 -type f -name "*.py" | python extract_modules_and_classes.py $2 $3 $4 $5 $6

