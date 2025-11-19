# Unit Converter in Smalltalk

This is a unit converter program I created in Smalltalk (Pharo).

This was designed after [my Zig unit converter](https://github.com/ahopk127/zig-units), which was in turn inspired by my project [7Units](https://ahopkins.ca/projects/#7units).

This project is not officially associated with Smalltalk in any way.

## Execution

1. Copy the unitfile in this repository into your Pharo image.  
   The destination filepath should be `[PHARO_PATH]/images/[IMAGE]/unitfile`.
2. Load this code into Pharo.
3. Execute the code `UnitsUI convertExpressions.` in the Playground.
4. Enter the expressions you wish to convert from and to in the boxes.

An output box should appear which shows you the conversion.

## Expression Format

Unit expressions are made in three parts:
* Any unit or number may be exponentiated by using the '^' character, for example 'm^3' represents the cubic metre.  Exponents, unlike all other numbers in expressions, must be integers.  Only one '^' can be used per term.  Do not put any spaces around the '^'.
* Any unit may have any prefix attached to it to scale its value, as done in the SI.  This system supports putting multiple prefixes on the same unit.
* Two exponent expressions, units or numbers can be divided using the '/' character.  For example, 'm^2/s^2' represents the square metre divided by the square second, equal to the expression 'J/kg'.  Only one '/' can be used per term.  Do not put any spaces around the '/'.
* Any number of any of the previous expressions can be separated by spaces to multiply them.  For example, the expression '1000 kg m/s^2' is equivalent to the kilonewton.

## Data File

All the data about the units and prefixes is stored in the special file `unitfile` in the root of this repository.  Each line creates a new unit or prefix.  This file can be changed to add new units and/or prefixes, and can be looked at for examples of the format.

The first word becomes the name of the unit or prefix, the second is the type of the line, and the remainder of the line is the value, interpreted differently depending on the line type:
* If the type is `base`, a new unit with no relation to any others is created.  The value is the numeric ID of the base - the same ID will result in the same unit.  Currently, this number must be a positive integer strictly less than `units.NUM_DIMENSIONS` (9 by default - for the SI base units, the radian and the bit).  This maximum can be changed in the code to allow for a different number of base units, though reducing it will break the current datafile, and reducing it below 3 will break the tests.  Note that adding a new base unit increases the size in memory of all other units, so don't set `units.NUM_DIMENSIONS` to a trillion unless you want terrible performance.
* If the type is `linear`, a new unit is created.  The line's value will be interpreted as a unit expression and evaluated to determine the value of the unit.
* If the type is `alias`, another name is given to the unit named in the line's value.  No expression will be evaluated, but the value can contain prefixes.
* If the type is `prefix`, a new prefix will be created.  The line's value will be parsed as a prefix expression with the same format as unit expressions, but where prefixes are used instead of units.  The final value should be a number.

The words must be separated with **one** space or tab character - more than one won't work.

Leading and trailing whitespace, empty lines and anything on or after the character '#' will be ignored.
