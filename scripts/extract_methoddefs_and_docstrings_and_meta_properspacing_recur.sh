#! /bin/sh

find $1 -type f -name "*.py" | python extract_methoddefs_and_docstrings_and_meta_properspacing.py $2 $3 $4 $5

