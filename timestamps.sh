#!/bin/bash
if [ $# -eq 0 ];then
	echo "Use a -s or -r parameter"
	exit 1
fi
if [ $1 = "-s" ];then
	rm -f timestamps;
	ls -l | sed -n 's/^.*Jan/01/p;s/^.*Feb/02/p;s/^.*Mar/03/p;s/^.*Apr/04/p;s/^.*May/05/p;s/^.*jun/06/p;s/^.*Jul/07/p;s/^.*Aug/08/p;s/^.*Sep/09/p;s/^.*Oct/10/p;s/^.*Nov/11/p;s/^.*Dec/12/p;' >> timestamps
fi
if [ $1 = "-r" ];then
	cat timestamps | while read line
do
	MONTH=$(echo $line | cut -f1 -d\ );
	echo $MONTH
	DAY=$(echo $line | cut -f2 -d\ );
	FILENAME=$(echo $line | cut -f4 -d\ );
	YEAR=$(echo $line | cut -f3 -d\ )
	echo $YEAR;
	CURRENTYEAR=$(cal | head -1 | cut -f5- -d\ | sed 's/ //g')
	echo $CURRENTYEAR
		if [[ $YEAR == *:* ]];then
			echo "111"
			touch -d ""$CURRENTYEAR-$MONTH-$DAY"" SFILENAME;
		else
			echo "222"
			touch -d ""$YEAR-$MONTH-$DAY"" SFILENAME;
		fi
done
fi
