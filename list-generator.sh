#!/bin/bash
#
#rswope - Evolve IP

#Generate host-ip csv list, run as cron job every night at midnight
SITE='test'
SOCKET="/omd/sites/$SITE/tmp/run/live"
OUTPUT='/tmp/a.txt'
INPUT='GET hosts\nColumns: host_name address\nSeparators: 10 44 44 124\nOutputFormat: csv'

echo "host_name,ip" > $OUTPUT
unixcat < <(echo -e "$INPUT") "$SOCKET" >> $OUTPUT
cat $OUTPUT
