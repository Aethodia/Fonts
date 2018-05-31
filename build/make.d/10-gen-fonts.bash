#!/usr/bin/env bash
## Copyright © from the date of the last git commit to this file in this git branch,
## by all persons with git blame to this file in this git branch, per the terms of
## the GNU AGPL 3.0 with the additional allowances of the GNU LGPL 3.0.

function genFont {
	fontforge -script 'build/common/genFont.py' "$1" "$2" "$3" 2>&1 | tail -n +4 1>&2
}

echo -e "\e[34;1m::\e[0;1m Generating fonts...\e[0m"
cd ../..
CWD=$(pwd)
cd src
for F in $(find -type f); do
	cd "$CWD"
	F="$(echo $F | sed 's/^.*[/]//gm' | sed 's/[.]sfd$//gm')"
	if [[ "$F" != '.'* ]] && [[ "$F" != *'~' ]]; then
		echo -e "\e[34;1m::\e[0m Compiling and hinting .ttf..."
		echo "bin/$F.ttf"
		## Compile a .ttf
		genFont 'gen' "src/$F.sfd" "bin/$F.ttf"
		## Hint that .ttf
		ttfautohint -c -i -W --hinting-limit=96 --hinting-range-max=36 --hinting-range-min=5 --increase-x-height=0 --strong-stem-width=gGD "bin/$F".ttf "bin/Hinted_$F.ttf" #-f #-p
		mv "bin/Hinted_$F.ttf" "bin/$F.ttf"
		## Save the modified font
		genFont 'rip' "bin/$F.ttf" "bin/$F.sfd"
		## Compile an .otf
		echo -e "\e[34;1m::\e[0m Compiling .otf from .ttf..."
		echo "bin/$F.otf"
		genFont 'gen' "bin/$F.sfd" "bin/$F.otf"
		rm -f "bin/$F.sfd"
	fi
done
echo -e "\e[34;1m::\e[0;1m Done.\e[0m"
exit 0
