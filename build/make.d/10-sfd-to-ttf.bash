#!/usr/bin/env bash
## Copyright © from the date of the last git commit to this file in this git branch,
## by all persons with git blame to this file in this git branch, per the terms of
## the GNU AGPL 3.0 with the additional allowances of the GNU LGPL 3.0.

echo -e "\e[34;1m::\e[0;1m Generating fonts...\e[0m"
cd ../../src
for F in $(find -type f); do
	F="$(echo $F | sed 's/^.*[/]//gm' | sed 's/[.]sfd$//gm')"
	if [[ "$F" != '.'* ]]; then
		echo "$F"
		fontforge -lang=ff -c 'Open($1); Generate($2)' "$F.sfd" "../bin/$F.ttf"
	fi
done
echo -e "\e[34;1m::\e[0;1m Done.\e[0m"
exit 0