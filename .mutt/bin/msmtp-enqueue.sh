#!/usr/bin/env bash

QUEUEDIR=$HOME/.msmtpqueue
sendmailcommand="/home/nhoutain/.mutt/bin/msmtp-runqueue.sh"

# Set secure permissions on created directories and files
umask 077

# Change to queue directory (create it if necessary)
if [ ! -d "$QUEUEDIR" ]; then
	mkdir -p "$QUEUEDIR" || exit 1
fi
cd "$QUEUEDIR" || exit 1

# Create new unique filenames of the form
# MAILFILE:  ccyy-mm-dd-hh.mm.ss[-x].mail
# MSMTPFILE: ccyy-mm-dd-hh.mm.ss[-x].msmtp
# where x is a consecutive number only appended if you send more than one
# mail per second.
BASE="`date +%Y-%m-%d-%H.%M.%S`"
if [ -f "$BASE.mail" -o -f "$BASE.msmtp" ]; then
	TMP="$BASE"
	i=1
	while [ -f "$TMP-$i.mail" -o -f "$TMP-$i.msmtp" ]; do
		i=`expr $i + 1`
	done
	BASE="$BASE-$i"
fi
MAILFILE="$BASE.mail"
MSMTPFILE="$BASE.msmtp"

# Write command line to $MSMTPFILE
echo "$@" > "$MSMTPFILE" || exit 1

# Write the mail to $MAILFILE
cat > "$MAILFILE" || exit 1

# If we are online, run the queue immediately.
# Check connection status
if ! ping -c1 www.google.com > /dev/null 2>&1; then
    # Ping could be firewalled ...
    # '-O -' will redirect the actual html to stdout and thus to /dev/null
    if ! wget -O - www.google.com > /dev/null 2>&1; then
	# Both tests failed. We are probably offline
	# (or google is offline, i.e. the end has come)
	exit 0;
    fi
fi

(${sendmailcommand} &> ~/.msmtp-queue.log) &

exit 0
