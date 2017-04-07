#! /bin/sh

find $1 -type f -name "*.py" | python extract_funcdefs_and_docstrings.py $2 $3 $4

