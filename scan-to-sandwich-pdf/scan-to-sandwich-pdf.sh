#!/bin/bash
#
#################################
# Scan to Sandwich-PDF by Alfcx #
#################################
#
###############
# Description #
###############
# This script optimizes scans and adds a text layer to the document 
# so you end up with a searchable and indexable pdf multipage document 
# (so called sandwich-pdf).
# The output file will be black/white for better text recognition.
# The original file gets saved in the archive directory 
# defined in the config.ini  (default: /home/$USER/Scan-Archive).
#
# Input:  pdf or tif singlepage or multipage document.
# Output: multipage pdf document (searchable, indexable, black/white).
#
################
# Dependencies #
################
# Make sure you have installed the following packages on your system: 
#    - zenity
#    - ghostscript 
#    - scantailor 
#    - tesseract-ocr (at least version 3.0.0)
#    - tesseract-ocr-deu tesseract-ocr-fra (and every other language-file you need)
#    - exactimage 
#    - pdftk
#
# You can do this using the following commands:
#   sudo apt-get update
#   sudo apt-get install zenity ghostscript scantailor tesseract-ocr tesseract-ocr-deu tesseract-ocr-fra exactimage pdftk
#
#########################################
# Script (no changes needed, hopefully) #
#########################################
#
# further variables
file="$1" ;
basename=`basename "$file"` ;
fbname="${basename%.*}" ;
basenamenospaces=`echo "$basename" | sed 's| |-|g'` ;
fbnamenospaces="${basenamenospaces%.*}" ;
filedir=`dirname "$file"` ;
scriptdir=`dirname "$0"` ;
langdir="$scriptdir/lang" ;
#
# Import config.ini
source "$scriptdir/config.ini" ;
#
# Get your language
lang="${MDM_LANG%_*}" ;
#
# Import the translation suiting your language. 
# If there's no translation for your language, import the english one.
if [ -f "$langdir/$lang.ini" ] ;
then source "$langdir/$lang.ini" ;
else source "$langdir/en.ini" ;
fi ;
#
# Import config.ini again
source "$scriptdir/config.ini" ;
#
# More Variables
workdir="$tmpdir/$fbnamenospaces" ;
archivename="`date +"%F_%H-%M-%S"`_$basenamenospaces" ;
#
# Ask for the primary language of the document
if ! SELTESSLANG=$(zenity --list \
                     --hide-header \
                     --title "$msg_sellang_title" \
                     --text="$msg_sellang_text" \
                     --width=400 --height=150 \
                     --radiolist --column "" --column "" TRUE "$lang1" FALSE "$lang2" FALSE "$lang3" ) ;
then exit ;
fi ;
#
case "$SELTESSLANG" in 
"$ger")TESSLANG="deu";;
"$fre")TESSLANG="fra";;
"$eng")TESSLANG="eng";;
esac 
#
# Go into directory
(
echo "0" ;
echo "# $msg_backup" ;
cd "$filedir" ;
#
# create direcotories
mkdir -p $tmpdir $workdir $archivedir ;
mkdir -p $workdir/c2p-tif $workdir/c2p-tif-out ;
#
# backup the original file
cp "$file" "$archivedir/$archivename" ;
#
# Split up the multipage document to single pages in tif-format
echo "13" ;
echo "# $msg_singlepage" ;
gs -q -dNOPAUSE -r300 -sDEVICE=tiffgray -sOutputFile="$workdir/c2p-tif/$fbname-%03d.tif" "$basename" -c quit ;
#
# call scantailor to split double pages, remove borders, black and white, etc.
# If scantailor removes too much Border add "--content-detection=cautious" 
# behind scantailor-cli (whith spaces and whitout the "")
echo '25' ;
echo "# $msg_scantailor" ;
for i in $workdir/c2p-tif/*.tif ;
do scantailor-cli --margins=5 --alignment=center --dpi=300 --output-dpi=300 "$i" "$workdir/c2p-tif-out" ;
done ;
#
# Optical character recognition by tesseract-ocr
echo "38" ;
echo "# $msg_ocr" ;
for i in $workdir/c2p-tif-out/*.tif ; 
do tesseract "$i" "$i" -l $TESSLANG -psm 1 hocr ;
done ;
#
# Generate sandwich-pdf (pdf-document with text layer and picture) single pages.
echo "50" ;
echo "# $msg_hocr2pdf" ;
for i in $workdir/c2p-tif-out/*.tif ;
do hocr2pdf -i "$i" -s -o "$i.pdf" < "$i.html" ;
done;
#
# Merge the single page pdf documents to a multipage pdf document
echo "63" ;
echo "# $msg_buildmultipage" ;
pdftk $workdir/c2p-tif-out/*.pdf cat output "$workdir/$fbname-big.pdf"
#
# Delete the original file
rm "$basename" ;
#
# Optimize the document's size
echo "75" ;
gs -sDEVICE=pdfwrite -sPAPERSIZE=a4 -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$fbname$suffix.pdf" "$workdir/$fbname-big.pdf" ;
#
# Clean up
echo "88" ;
rm $workdir/c2p-tif/*.tif $workdir/c2p-tif-out/*.tif $workdir/c2p-tif-out/*.html $workdir/c2p-tif-out/*.pdf $workdir/c2p-tif-out/cache/speckles/*.tif $workdir/*.pdf ;
rmdir $workdir/c2p-tif $workdir/c2p-tif-out/cache/speckles $workdir/c2p-tif-out/cache $workdir/c2p-tif-out $workdir ;
echo "100" ;
echo "# $msg_success" ;
) | zenity --progress \
     --title "$msg_prog_title" \
     --text "$msg_prog_text" \
     --pulsate --width=400 --auto-close --auto-kill ;
zenity --info  \
  --title="$msg_fin_title" \
  --text="$msg_fin_text" \
  --no-wrap ;
