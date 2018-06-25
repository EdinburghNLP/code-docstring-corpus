#! /bin/bash

#set -o xtrace

for f in $(find . -not -path '*/\.*' -type f)
do
  echo $f
  if [[ $f == *.gz ]]
  then
    GZIPPED=true
  else
    GZIPPED=false
  fi
  if $GZIPPED
  then
    gunzip $f
    f=${f%.gz}
  fi
  tr -d '\r' < $f >$f.nonewline
  mv $f.nonewline $f
  if $GZIPPED
  then
    gzip $f
  fi
done


