#!/bin/bash

BASEDIR=$(dirname "$0")
source $BASEDIR/helperFuncs/mainDBMS_menu.sh $BASEDIR



dataBaseDIR=`pwd`/DataBases
if [ ! -d $dataBaseDIR ]
then
mkdir $dataBaseDIR
echo ">> DataBasesDIR Created Successfully"
fi
mainDBMSMenu $dataBaseDIR




