#!/bin/bash

# PIN setup
PIN=4
gpio -g mode $PIN out;

# Basic morse
DOT=.1
DASH=$DOT*3
SPACE=$DOT*7
long() {
	gpio -g write $PIN 1;
	sleep $DASH;
	gpio -g write $PIN 0;
	sleep $DOT;
}
short() {
	gpio -g write $PIN 1;
	sleep $DOT;
	gpio -g write $PIN 0;
	sleep $DOT;
}

# E.g. "as y"
# dot<dot>dash  <dash>  dot<dot>dot<dot>dot<dot> <space> dash<dot>dot<dot>dash<dot>dash<dot>
# [     a    ] [len=3]  [           s          ] [len=7] [                y                ]

# Blink by morse function
morse() {
case $1 in
	1)
		short;long;long;long;long; sleep $DASH;
		;;
	2)
		short;short;long;long;long; sleep $DASH;
		;;
	3)
		short;short;short;long;long; sleep $DASH;
		;;
	4)
		short;short;short;short;long; sleep $DASH;
		;;
	5)
		short;short;short;short;short; sleep $DASH;
		;;
	6)
		long;short;short;short;short; sleep $DASH;
		;;
	7)
		long;long;short;short;short; sleep $DASH;
		;;
	8)
		long;long;long;short;short; sleep $DASH;
		;;
	9)
		long;long;long;long;short; sleep $DASH;
		;;
	0)
		long;long;long;long;long; sleep $DASH;
		;;
	*)
		sleep $SPACE;
		;;
esac
}

# code begin
short; short; short;
sleep $DASH;

# get ip and show morse code on pin 4+5 (gpio4 + gnd)
if [ $1 ]; then
	text=$1;
else
	text=$(hostname -I | grep -Po "^\d+\.\d+\.\d+\.\d+");
fi;
for (( i=0; i<${#text}; i++ )); do
	echo "${text:$i:1}";
	morse "${text:$i:1}";
done
