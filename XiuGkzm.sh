#!/bin/bash
for i in `ls *.txt`
do
  n=${i%.*}
  mv $i $n.doc
done
