#!/bin/bash
#
# This script demonstrate I/O redirection.

# Redirect STDOUT to a file.
FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

# Redirect STDIN to a program.
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

# Redirect STDOUT to a file, overwriting the file.
head -n3 /etc/passwd > ${FILE}
echo
echo "Contents of $FILE: "
cat ${FILE}

# Redirect STDOUT to a file, appending to the file
echo "$RANDOM $RANDOM" >> $FILE
echo "$RANDOM $RANDOM" >> $FILE
echo
echo "Contents of $FILE:"
cat $FILE 

# Redirect STDIN to a program, using FD 0.
read LINE 0< ${FILE}
echo
echo "LINE contains: ${LINE}"

# Redirect STDOUT to a file using FD 1, overwiriting the file.
head -n3 /etc/passwd 1> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect stderr to a file using FD 2
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2>${ERR_FILE}

# Redirect stdout and sterr to a file
head -n3 /etc/passwd /fakefile &> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect stdout and stderr through a pipe
echo
head -n3 /etc/passwd /fakefile |& cat -n

# Send output to stderr
echo "This is STDERR!" >&2

# Discard stdout
echo
echo "Discarding STDOUT: "
head -n3 /etc/passwd /fakefile > /dev/null

# Discard stderr
echo
echo "Discarding STDERR:"
head -n3 /etc/passwd /fakefile 2> /dev/null

# discarding stdout and stderr both
echo
echo "Discarding STDOUT and STDERR:"
head -n3 /etc/passwd /fakefile &> /dev/null

# clean up
rm ${FILE} ${ERR_FILE} &> /dev/null
