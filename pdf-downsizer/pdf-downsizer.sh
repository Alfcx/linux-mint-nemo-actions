#!/bin/bash
#
##########################
# PDF Downsizer by Alfcx #
##########################
#
# Import Settings
scriptdir=`dirname "$0"` ;
source "$scriptdir/config.ini" ;
#
# Get your language
lang="${MDM_LANG%_*}" ;
#
# Imort the translation suiting your language. 
# If there's no translation for your language, import the english one.
langdir="$scriptdir/lang"
if [ -f "$langdir/$lang.ini" ] ;
then source "$langdir/$lang.ini" ;
else source "$langdir/en.ini" ;
fi ;
#
# Get the file's directory
filedir=`dirname "$1"` ;
#
# prepare archive directory
mkdir -p "$archivedir" ;
#
# backup the original file
cp "$filedir/$basename" "$archivedir/$archivename" ;
#
# downsize the file
(
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$filedir/$basename" "$archivedir/$archivename" ;
) | zenity --progress \
     --title "$progress_title" \
     --text "$progress_text" \
     --pulsate --width=500 --auto-close --auto-kill ;
#
# Finished
zenity --info  \
  --title="$finished_title" \
  --text="$finished_text" \
  --no-wrap ;
