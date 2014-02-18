#!/bin/bash
# Archive (change if you want)
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
# resize the file
(
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$dirname/$basename" "$archivedir/$archivename" ;
) | zenity --progress \
     --title "Dokument wird verkleinert" \
     --text "«$basename» wird verkleinert" \
     --pulsate --width=500 --auto-close --auto-kill ;
#
# Finished
zenity --info  \
  --text="«`echo "$basename"`» wurde erfolgreich verkleinert. 
Eine Kopie des Originals wurde im Archiv (`echo "$archivedir"`) abgelegt." \
  --title="Dokument verkleinert" \
  --no-wrap --width=500 ;
