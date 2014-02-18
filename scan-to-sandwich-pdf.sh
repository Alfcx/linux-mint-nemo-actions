#!/bin/bash
nemoactionsdir=`dirname "$0"` ;
if [[ $MDM_LANG =~ de ]] ; 
   then $nemoactionsdir/scan-to-sandwich-pdf-de.sh $1 ;
   else $nemoactionsdir/scan-to-sandwich-pdf-en.sh $1 ;
fi ;
