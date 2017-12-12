#!/bin/bash
#Ryan Swope - Evolve IP

# Testing ssh connection for hosts
MYSQL='/usr/bin/mysql -ureadonly -preadonly -N oreka --host=cr2-web-dev.evolveip.net'
queue="$1"
SSHPASS="/usr/bin/sshpass"

mysqloutput=`echo "select esd_user,esd_pwkey,esd_port,esd_host from eipsftpdelivery where esd_queueDirectory = \"$queue\"  LIMIT 1" | $MYSQL | sed 's/[\t ]\+/ /g'`

read USER PASSWD esd_port HOST <<< `echo $mysqloutput`
export USER
export PASSWD
if [ "$mysqloutput" != "" ]; then
        echo "Testing..."
        if [ "$esd_port" == "22" ]; then
                echo "Port 22"
        export SSHPASS=$PASSWD
sshpass -e sftp $USER@$HOST 1> /dev/null 2>&1 << EOF
exit
EOF
                if [ $? == 0 ]; then
                        echo "STFP/Ssh successful."
                else
                        echo "STFP/Ssh failure."
                fi
        elif [ "$esd_port" == "21" ]; then
#Ftp program uses env variables PASSWD, USER, HOST
lftp $HOST -u $USER,$PASSWD 1> /dev/null 2>&1  << END_SCRIPT
quote USER $USER
quote PASS $PASSWD
ls
quit
END_SCRIPT
                if [ $? == 0 ]; then
                        echo "lftp successful."
                else
                        echo "lftp failure."
                fi
        fi
else
        echo "Blank queue. Enter valid queue."
fi
