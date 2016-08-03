#!/bin/bash
IFS=":"
while read -r group a gid users
do
	GID=`getent group | grep $gid | cut -d: -f3`
	MEMBERS=`getent passwd | grep -v nfsnobody | awk -F: '$3 >= 10000' | grep $GID | cut -d: -f1`
	GROUP=`getent group | grep $GID | cut -d: -f1`
	IFS=$'\n'
	for name in $MEMBERS; do
		UserID=`getent passwd | grep -v nfsnobody | awk -F: '$3 >= 10000' | grep $name | cut -d: -f3`
	        echo $name:$GROUP
	done
	IFS=":"
done < <(getent group | grep -v nfsnobody | awk -F: "\$3 >= 10000")
