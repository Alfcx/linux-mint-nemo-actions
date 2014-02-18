#!/bin/bash
nemoactionsdir=`dirname "$0"` ;
if [[ $MDM_LANG =~ de ]] ; 
   then $nemoactionsdir/pdf-metadata-edit-de.sh $1 ;
   else $nemoactionsdir/pdf-metadata-edit-en.sh $1 ;
fi ;
