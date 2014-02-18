#!/bin/bash
nemoactionsdir=`dirname "$0"` ;
if [[ $MDM_LANG =~ de ]] ; 
   then $nemoactionsdir/pdf-rotate-de.sh $1 ;
   else $nemoactionsdir/pdf-rotate-en.sh $1 ;
fi ;
