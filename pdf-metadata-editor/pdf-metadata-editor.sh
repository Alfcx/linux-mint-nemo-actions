#!/bin/bash
#
################################
# PDF Metadata Editor by Alfcx #
################################
#
# Directory for temporary files (change if you like)
tmpdir="/tmp/pdf-metadata" ;
#
# Get your language
lang="${MDM_LANG%_*}" ;
#
# Imort the translation suiting your language. 
# If there's no translation for your language, import the english one.
scriptdir=`dirname "$0"` ;
langdir="$scriptdir/lang" ;
if [ -f "$langdir/$lang.ini" ] ;
then source "$langdir/$lang.ini" ;
else source "$langdir/en.ini" ;
fi ;
#
file="$1" ;
dirname=`dirname "$file"` ;
basename=`basename "$file"` ;
#
# prepare tmpdir and copy file
mkdir -p "$tmpdir" ;
cp "$dirname/$basename" "$tmpdir/$basename" ;
# Ask for the title
if ! TITLE=$(zenity --entry \
  --title="$title_title" \
  --text="$title_text" \
  --width=300) ; then
  exit;
fi ;
# Ask for the author's name
if ! AUTHOR=$(zenity --entry \
  --title="$author_title" \
  --text="$author_text" \
  --width=300) ; then
  exit;
fi ;
# Get the existing metadata
pdftk "$tmpdir/$basename" dump_data output "$tmpdir/$basename.txt"
# Remove existing entries
sed -i '/InfoKey: Title/{n;/.*/d;}' "$tmpdir/$basename.txt" ;
sed -i '/InfoKey: Title/d' "$tmpdir/$basename.txt" ;
sed -i '/InfoKey: Author/{n;/.*/d;}' "$tmpdir/$basename.txt" ;
sed -i '/InfoKey: Author/d' "$tmpdir/$basename.txt" ;
# Add new entries
sed -i '1iInfoBegin' "$tmpdir/$basename.txt" ;
sed -i '1aInfoKey: Title' "$tmpdir/$basename.txt" ;
sed -i "2aInfoValue: $TITLE" "$tmpdir/$basename.txt" ;
sed -i '1iInfoBegin' "$tmpdir/$basename.txt" ;
sed -i '1aInfoKey: Author' "$tmpdir/$basename.txt" ;
sed -i "2aInfoValue: $AUTHOR" "$tmpdir/$basename.txt" ;
# Replace special letters you can't use in metadata
sed -i 's|ä|ae|g;s|ü|ue|g;s|ö|oe|g;s|é|e|g;s|è|e|g;s|à|a|g;s|ê|e|g;s|ç|c|g;s|ô|o|g' "$tmpdir/$basename.txt" ;
# Update the metadata
pdftk "$tmpdir/$basename" update_info "$tmpdir/$basename.txt" output "$dirname/$basename" ;
# Clean up
rm "$tmpdir/$basename.txt" "$tmpdir/$basename" ;
