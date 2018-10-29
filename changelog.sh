#! /bin/bash

zen_bin=$(find /usr/{bin,local/bin} -name zenity)

qa_message="IMPORTANT NOTICE\nWill you display changelog ?"	
last_change=$(cat CHANGELOG.md | sed -n "/^\(### Change Log\)/,/^\(\s*\)$/p")
if ! [[ $zen_bin ]]; then
	echo -e "### Zenity is required to display changelog message with a graphical interface.\nPlease, install it first with your default package manager to get it at next 'make' launch.\n"
	echo -e "$last_change"
else
	$zen_bin --width=200 --title='Last Change Log' --question --text="$qa_message"
	if [ $? = 0 ]; then
		(printf "$last_change")|$zen_bin --width=520 --height=360 --title='Last Change Log' --text-info
	fi
fi

exit 0
