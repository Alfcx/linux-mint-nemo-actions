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
selrotation=$(zenity --list \
                     --hide-header \
                     --text="Define the rotation. The rotation ist always calculated based on the initial value. If you \nrotated 90° clockwise and realize, that you should have rotated 90° counterclockwise,\nyou can correct it through rotating 90° counterclockwise and not through rotating 180°. " \
                     --title "Rotate «$basename»" \
                     --height 202 \
                     --radiolist --column "" --column "" TRUE "Turn the pages 90° clockwise" FALSE "Turn the pages 90° counterclockwise" FALSE "Turn the pages 180°" FALSE "Turn the pages back to their initial state" ) ;
#
case "$selrotation" in 
"Turn the pages 90° clockwise")rotation="1-endeast";;
"Turn the pages 90° counterclockwise")rotation="1-endwest";;
"Turn the pages 180°")rotation="1-endsouth";;
"Turn the pages back to their initial state")rotation="1-endnorth";;
esac 
#
# Work it & clean up
mkdir -p $tmpdir ;
mv "$dir/$basename" "$tmpdir/$basename" ;
pdftk "$tmpdir/$basename" cat "$rotation" output "$dir/$basename" ;
rm "$tmpdir/$basename" ;
