#!/bin/bash
nemoactionsdir=`dirname "$0"` ;
if [[ $MDM_LANG =~ de ]] ; 
   then $nemoactionsdir/pdf-downsize-de.sh $1 ;
   else $nemoactionsdir/pdf-downsize-en.sh $1 ;
fi ;
