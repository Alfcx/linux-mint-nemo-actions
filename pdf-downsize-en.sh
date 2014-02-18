#!/bin/bash
# Archive Directory (change if you want)
archivedir="/home/$USER/Scan-Archive" ;
#
# Further Variables
file="$1" ;
basename=`basename "$file"` ;
basenamenospaces=`echo "$basename" | sed 's| |_|g'` ;
dirname=`dirname "$file"` ;
archivename="`date +"%F_%H-%M-%S"`_$basenamenospaces" ;
#
# prepare directories
mkdir -p $archivedir
#
# backup the original file
cp "$dirname/$basename" "$archivedir/$archivename"
#
# downsize the file
(
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$dirname/$basename" "$archivedir/$archivename" ;
) | zenity --progress \
     --title "Downsizing in progress" \
     --text "«$basename» is being processed." \
     --pulsate --width=500 --auto-close --auto-kill ;
#
# Finished
zenity --info  \
  --text="«`echo "$basename"`» has been successfully downsized.\nA copy of the original file lies in the Archive (`echo "$archivedir"`)." \
  --title="Document downsized" \
  --no-wrap --width=500 ;
