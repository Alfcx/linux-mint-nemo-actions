#!/bin/bash
#
#######################
# PDF Merger by Alfcx #
#######################
#
dir=`dirname "$1"` ;
#
# Get settings from config.ini
scriptdir=`dirname "$0"` ;
source "$scriptdir/config.ini" ;
#
# Get your language
lang="${MDM_LANG%_*}" ;
#
# Imort the translation suiting your language. 
# If there's no translation for your language, import the english one.
langdir="$scriptdir/lang" ;
if [ -f "$langdir/$lang.ini" ] 
   then source "$langdir/$lang.ini" ;
   else source "$langdir/en.ini" ;
fi ;
#
# Ask for the Name of the output file
if ! OUTPUTNAME=$(zenity --entry \
  --title="$output_title" \
  --text="$output_text" \
  --width=300) ; then
  exit;
fi ;
# 
# Merge the files
pdftk "$@" cat output "$dir/$OUTPUTNAME.pdf" ;
#
# Delete input files (only if set to true in config.ini)
if [[ "$delinput" = "true" ]] 
   then rm $inputfiles ;
fi ;
