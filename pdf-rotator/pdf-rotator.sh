#!/bin/bash
#
########################
# PDF Rotator by Alfcx #
########################
#
# Directory for temporary files (change if you like)
tmpdir="/tmp/pdf-rotate" ;
#
# Further Variables
file="$1"; 
dir=`dirname "$file"` ;
basename=`basename "$file"` ;
#
# Get your language
lang="${MDM_LANG%_*}" ;
#
# Imort the translation suiting your language. 
# If there's no translation for your language, import the english one.
scriptdir=`dirname "$0"` ;
langdir="$scriptdir/lang"
if [ -f "$langdir/$lang.ini" ] ;
then source "$langdir/$lang.ini" ;
else source "$langdir/en.ini" ;
fi ;
#
# Ask for rotation
if ! SELROTATION=$(zenity --list \
                     --hide-header \
                     --text="$text" \
                     --title "$title" \
                     --height="$height" \
                     --radiolist --column "" --column "" TRUE "$rot90cw" FALSE "$rot90ccw" FALSE "$rot180" FALSE "$rotback" ) ;
then exit ;
fi ;
#
case "$SELROTATION" in 
"$rot90cw")ROTATION="1-endeast";;
"$rot90ccw")ROTATION="1-endwest";;
"$rot180")ROTATION="1-endsouth";;
"$rotback")ROTATION="1-endnorth";;
esac
#
# Work it & clean up
mkdir -p $tmpdir ;
mv "$dir/$basename" "$tmpdir/$basename" ;
pdftk "$tmpdir/$basename" cat "$ROTATION" output "$dir/$basename" ;
rm "$tmpdir/$basename" ;
