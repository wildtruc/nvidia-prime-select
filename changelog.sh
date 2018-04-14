#! /bin/bash

zen_bin=$(find /usr/{bin,local/bin} -name zenity)
qa_message="IMPORTANT NOTICE\nWill you display changelog ?"

$zen_bin --width=200 --title='Last Change Log' --question --text="$qa_message"
if [ $? = 1 ]; then
	exit 0
else
	last_change=$(cat CHANGELOG.md | sed -n "/^\(### Change Log\)/,/^\(\s*\)$/p")
	(printf "$last_change")|$zen_bin --width=520 --height=360 --title='Last Change Log' --text-info 
fi

exit 0
