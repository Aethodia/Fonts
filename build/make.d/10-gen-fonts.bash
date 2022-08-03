#!/usr/bin/env bash
## Copyright © from the date of the last git commit to this file in this git branch,
## by all persons with git blame to this file in this git branch, per the terms of
## the GNU AGPL 3.0 with the additional allowances of the GNU LGPL 3.0.

function genFont {
	fontforge -script 'build/common/genFont.py' "$1" "$2" "$3" 2>/dev/null 1>/dev/null
}

echo -e "\e[34;1m::\e[0;1m Generating fonts...\e[0m"
cd ../..
CWD=$(pwd)
cd src
for F in $(find -type f); do
	cd "$CWD"
	F="$(echo $F | sed 's/^.*[/]//gm' | sed 's/[.]sfd$//gm')"
	if [[ "$F" != '.'* ]] && [[ "$F" != *'~' ]]; then
		echo -e "\n\e[34;1m::\e[0m Compiling .ttf..."
		echo "bin/$F.ttf"

		## Compile a .ttf
		genFont 'gen' "src/$F.sfd" "bin/$F.ttf"
		if [[ ! -f "bin/$F.ttf" ]]; then
			echo 'Failed to compile font!'
			exit 1
		fi

		## Optimize the .ttf
		echo -e "\e[34;1m::\e[0m Optimizing .ttf..."
		fonttools otlLib.optimize "bin/$F.ttf"
		fonttools cffLib.width "bin/$F.ttf"

		## Hint the .ttf
		echo -e "\e[34;1m::\e[0m Hinting .ttf..."
		ttfautohint -iW --default-script=latn --fallback-script=latn --fallback-stem-width=100 --hinting-limit=96 --hinting-range-max=36 --hinting-range-min=5 --increase-x-height=12 --stem-width-mode=qsq "bin/$F.ttf" "bin/Hinted_$F.ttf" #-p
		if [[ ! -f "bin/Hinted_$F.ttf" ]]; then
			echo 'Failed to hint font!' >&2
			exit 2
		fi
		mv "bin/Hinted_$F.ttf" "bin/$F.ttf"

		## Compile an .otf from the .ttf
		echo -e "\n\e[34;1m::\e[0m Compiling .otf..."
		genFont 'rip' "bin/$F.ttf" "bin/$F.sfd"
		echo "bin/$F.otf"
		genFont 'gen' "bin/$F.sfd" "bin/$F.otf"
		rm -f "bin/$F.sfd"

		## Optimize the .otf
		echo -e "\e[34;1m::\e[0m Optimizing .otf..."
		fonttools otlLib.optimize "bin/$F.otf"
		fonttools cffLib.width "bin/$F.otf"
		# fonttools subset "bin/$F.otf" #TODO: Come up with a good list of arguments for this.

		## Generate .woff/.woff2 from .otf
		echo -e "\n\e[34;1m::\e[0m Compiling .woff and .woff2..."
		woff "bin/$F.otf"
		mv "$F.woff" "bin/"
		fonttools ttLib.woff2 compress "bin/$F.otf"
	fi
done
echo -e "\n\e[34;1m::\e[0;1m Done.\e[0m"
exit 0
