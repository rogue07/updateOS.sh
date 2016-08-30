#!/bin/bash

# 18 jan, 2016 - created script
# 19 jan, 2016 - adding logging
#              - added hostname variable
# 02 mar, 2016 - added check for Ubuntu


###########
# Logging #
###########
LOG=/tmp/updateOS.log
LOG2=/tmp/updateOS.log2
touch /tmp/updateOS.log
touch /tmp/updateOS.log2

minimumsize=90000
actualsize=$(wc -c "$LOG2" | cut -f 1 -d ' ')
if [ $actualsize -ge $minimumsize ]; then
    echo Size is over $minimumsize bytes
    echo Emptying log2
    echo > $LOG2
else
    echo Size is under $minimumsize bytes
    echo Moving on, nothing to see here
fi

cat $LOG >> $LOG2
echo > $LOG

############
# Variable #
############
HOSTNAME=$(cat /etc/hostname)
OS=$(cat /etc/issue | awk "{print $1}" | cut -c 1-6)

########
# Main #
########
if [ "$OS" == "Ubuntu" ]; then
	echo
	echo "This is Ubuntu, running apt-get." | tee -a $LOG
	echo "Running apt-get update:" | tee -a $LOG
	apt-get -y update | tee -a $LOG
	echo "Running apt-get upgrade:" | tee -a $LOG
	apt-get -y upgrade | tee -a $LOG
	echo "Running apt-get clean:" | tee -a $LOG
	apt-get clean | tee -a $LOG
else
	echo
	echo "This is Fedora, running dnf update." | tee -a $LOG
	dnf update -y | tee -a $LOG
fi

curl http://textbelt.com/text -d "number=3523969626" -d "message=Sir, $HOSTNAME has been updated." | tee -a $LOG

