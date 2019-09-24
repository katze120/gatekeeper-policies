#!/bin/sh

for i in `ls library`
do 
  opa test -v --explain=notes --ignore library/${i}/template.yaml library/${i}
done
