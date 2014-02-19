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
                     --text="Definiere die Drehung. Bei wiederholter Anwendung wird ausgehend vom ursprünglichen Wert gedreht. \nWenn beispielsweise 90° im Uhrzeigersinn gedreht wurde und eigentlich 90° im Gegenuhrzeigersinn \nhätte gedreht werden sollen, dann muss zur Korrektur um 90° im Gegenuhrzeigersinn rotiert werden \nund nicht um 180°." \
                     --title "Drehe «$basename»" \
                     --height 217 \
                     --radiolist --column "" --column "" TRUE "Um 90° im Uhrzeigersinn drehen" FALSE "Um 90° im Gegenuhrzeigersinn drehen" FALSE "Um 180° drehen" FALSE "Ausgangszustand wiederherstellen" ) ;
then exit ;
fi ;
#
case "$SELROTATION" in 
"Um 90° im Uhrzeigersinn drehen")ROTATION="1-endeast";;
"Um 90° im Gegenuhrzeigersinn drehen")ROTATION="1-endwest";;
"Um 180° drehen")ROTATION="1-endsouth";;
"Ausgangszustand wiederherstellen")ROTATION="1-endnorth";;
esac
#
# Work it & clean up
mkdir -p $tmpdir ;
mv "$dir/$basename" "$tmpdir/$basename" ;
pdftk "$tmpdir/$basename" cat "$ROTATION" output "$dir/$basename" ;
rm "$tmpdir/$basename" ;
