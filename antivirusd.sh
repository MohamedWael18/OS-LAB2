#!/bin/bash
ls -l $1 > directory-info.last
TIMER="$2s"
mkdir -p malicious_dir
while true; do
	sleep "$TIMER"
	ls -l $1 > directory-info.new
	ls -1 $1 > names.new
	if cmp -s "directory-info.last" "directory-info.new"; then
		echo "No change"
	else
		while IFS= read -r line; do
			if [[ -z "$line" || "$line" == "directory-info.last" || "$line" == "directory-info.new" || "$line" == "names.new" ]]; then
				continue
			fi
			filepath="./$1/$line"
			filepath="${filepath//\/\///}"

			if [[ "$line" == *.exe || "$line" == *.bat || "$line" == *.vbs || "$line" == *.scr || "$line" == *.ps1 ]] || 
			([ -f "$filepath" ] && grep -Eq "ransomware|worm|malware|trojan|virus" "$filepath"); then

				echo "$line is malicious and it is DELETED"
				mv "$filepath" malicious_dir/
			fi			
		done < names.new
		cp "directory-info.new" "directory-info.last"
	fi
done
