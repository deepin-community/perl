?RCS: Copyright (c) 2022 H.Merijn Brand
?RCS:
?RCS: You may distribute under the terms of either the GNU General Public
?RCS: License or the Artistic License, as specified in the README file.
?RCS:
?MAKE:d_setenv: Inlibc
?MAKE:	-pick add $@ %<
?S:d_setenv:
?S:	This variable conditionally defines the HAS_SETENV symbol, which
?S:	indicates to the C program that the setenv() routine is available.
?S:.
?C:HAS_SETENV:
?C:	This symbol, if defined, indicates that the setenv() routine is
?C:	available to change or add an environment variable.
?C:.
?H:#$d_setenv HAS_SETENV	/**/
?H:.
?LINT:set d_setenv
: see if setenv exists
set setenv d_setenv
eval $inlibc

