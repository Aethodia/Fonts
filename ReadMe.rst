ReadMe
################################################################################

Description
================================================================================
| This repository contains the sources for Aethodic, a family of fonts for the
  Aethodic script.
| The completed font consists of everything under ``/bin`` after a build.

Copyright
================================================================================
| (See ``/Copyright.txt`` for more info)
- Code is licensed under the GNU Lesser Affero General Public License 3.0 (LAGPL 3).
- Non-code is licensed under the Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4) license.

Usage
================================================================================
- ``build/Makefile.bash make``:  Build the font from sources.
- ``build/Makefile.bash clean``:  Clean the ``/bin`` directory for a fresh build.

Dependencies
================================================================================
| The following programs must be present on the system in order to build or run
  this software.  Dependencies that are both runtime and build dependencies, are
  only shown in the "Runtime dependencies" section.
- Runtime dependencies

  - (no additional dependencies)

- Build dependencies

  - fontforge
  - ttfautohint (v1.8+)
