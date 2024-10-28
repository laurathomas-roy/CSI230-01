#!bin/bash

#access web page 20 times in a row

#for loop that will execute 20 times
for i in $(seq 1 20);
do
	#in for loop, call curl
	curl 10.0.17.32
done
