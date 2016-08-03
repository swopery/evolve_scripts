#!/bin/bash
#
#Ryan Swope - Evolve IP (7/16)
PORT=
IFS="\n"
OUTPUT=/tmp/ip_porttest_output.txt
echo "name:ip:port" > "$OUTPUT"

tail -n +2 /home/ryoung/bin/List-Of-IPs.csv | grep -i _EW |  while read i
do
	HOST=`echo "$i" | cut -d, -f1`
	IP=`echo "$i" | cut -d, -f2`

	nc -z -w1 "$IP" 443 1> /dev/null 2>&1
        if [ $? == 0 ]; then
		PORT=443
	else 
		nc -z -w1 "$IP" 81 1> /dev/null 2>&1
		if [ $? == 0 ]; then
        		PORT=81
		else 
			nc -z -w1 "$IP" 80 1> /dev/null 2>&1
			if [ $? == 0 ]; then
        			PORT=80
			fi
		fi
	fi
	if [  -z $PORT ]; then
		PORT='fail'
	fi
	echo "$HOST:$IP:$PORT" >> "$OUTPUT"
	PORT=
	HOST=
	IP=
done
