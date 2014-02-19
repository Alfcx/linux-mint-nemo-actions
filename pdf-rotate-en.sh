#!/bin/bash
#
# Directory for temporary files
tmpdir="/tmp/pdf-rotate" ;
#
# Further Variables
file="$1"; 
dir=`dirname "$file"` ;
basename=`basename "$file"` ;
#
# Ask for rotation
if ! SELROTATION=$(zenity --list \
                     --hide-header \
                     --text="Define the rotation. The rotation ist always calculated based on the initial value. If you \nrotated 90° clockwise and realize, that you should have rotated 90° counterclockwise,\nyou can correct it through rotating 90° counterclockwise and not through rotating 180°. " \
                     --title "Rotate «$basename»" \
                     --height 202 \
                     --radiolist --column "" --column "" TRUE "Turn the pages 90° clockwise" FALSE "Turn the pages 90° counterclockwise" FALSE "Turn the pages 180°" FALSE "Turn the pages back to their initial state" ) ;
then exit ;
fi ;
#
case "$SELROTATION" in 
"Turn the pages 90° clockwise")ROTATION="1-endeast";;
"Turn the pages 90° counterclockwise")ROTATION="1-endwest";;
"Turn the pages 180°")ROTATION="1-endsouth";;
"Turn the pages back to their initial state")ROTATION="1-endnorth";;
esac
#
# Work it & clean up
mkdir -p $tmpdir ;
mv "$dir/$basename" "$tmpdir/$basename" ;
pdftk "$tmpdir/$basename" cat "$ROTATION" output "$dir/$basename" ;
rm "$tmpdir/$basename" ;
