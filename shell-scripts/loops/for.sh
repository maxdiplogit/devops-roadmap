#!/usr/bin/env bash

a=(10 20);
b[0]="x y z";
b[1]=1;

for var in "${b[@]}";
do
	echo $var;
done
