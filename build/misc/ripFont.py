#!/usr/bin/env python
# coding=utf-8
## Copyright © from the date of the last git commit to this file in this git branch,
## by all persons with git blame to this file in this git branch, per the terms of
## the GNU AGPL 3.0 with the additional allowances of the GNU LGPL 3.0.
# Baby's first Python script
## Expects two variables

## Imports
import fontforge
import sys

## Main
try:
	## Open the font
	## Since this file only gets called from a particular bash file, the file's existence
	## has already been checked.
	font = fontforge.open(sys.argv[1])

	## Decomepile the given font and save as an .sfd.
	## Since this file only gets called from a particular bash file, we don't need to
	## check whether enough arguments were passed in.
	font.save(sys.argv[2])

	## Close the font for reading
	font.close()

except:
	## If there were any errors, quit with an error code.
	sys.exit(1)

## If there were no errors, quit successfully.
sys.exit(0)
