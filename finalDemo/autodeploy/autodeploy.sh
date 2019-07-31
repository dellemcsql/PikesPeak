#!/bin/bash

echo "Please enter deployment Type [Dev/TW] : "
read deployType;
echo "Please enter no of copies to be deployed : "
read noOfDeploy;
echo "Please enter opertaion to be performed [delete/create] : "
read oper;
#deployType=$1;
#noOfDeploy=$2;
#oper=$3;

if [ $noOfDeploy -le 0 -o $noOfDeploy -ge 10 ] 
then
	echo "Please check second parameter..";
fi


pvc="developer-copy-pvc";
deploy="developer-copy-depl";
#app="developer-copy-depl";
appContainer="developer-copy-app";
dbContainer="developer-copy-mssql";
appSvc="developer-http"
dbSvc="developer-sql"

echo "noOfDeploy=$noOfDeploy"


while [ "$noOfDeploy" != 0 ]
do
  echo "Generating $noOfDeploy copy config.."
  #read INPUT_STRING
  #declare -g new_pvc="$pvc_$i"
  new_pvc="$pvc-$noOfDeploy"
  new_deploy="$deploy-$noOfDeploy"
 # new_app="$app-$noOfDeploy"
  new_appContainer="$appContainer-$noOfDeploy"
  new_dbContainer="$dbContainer-$noOfDeploy"
  new_appSvc="$appSvc-$noOfDeploy"
  new_dbSvc="$dbSvc-$noOfDeploy"

  extn=".yaml"
  newFileName="$new_deploy$extn"

: '
  echo "Creating config file for $newFileName"
  echo "new_pvc: $new_pvc"  
  echo "new_deploy: $new_deploy"
  echo "new_app: $new_app"
  echo "new_appContainer: $new_appContainer"
  echo "new_dbContainer: $new_dbContainer"
  echo "new_appSvc: $new_appSvc"
  echo "new_dbSvc: $new_dbSvc"
'

  #sed -e "s/$pvc/$new_pvc/ig;s/$deploy/$new_deploy/ig;s/$appContainer/$new_appContainer/ig;s/$dbContainer/$new_dbContainer/ig;s/$appSvc/$new_appSvc/ig;s/$dbSvc/$new_dbSvc/ig" initialtemplate.yaml > tempfile.tmp
  #mv tempfile.tmp $newFileName 

  if [ "$oper" = "create" ];
  then
        sed -e "s/$pvc/$new_pvc/ig;s/$deploy/$new_deploy/ig;s/$appContainer/$new_appContainer/ig;s/$dbContainer/$new_dbContainer/ig;s/$appSvc/$new_appSvc/ig;s/$dbSvc/$new_dbSvc/ig" initialtemplate.yaml > tempfile.tmp
  	mv tempfile.tmp $newFileName
        cmd="kubectl create -f $newFileName"
        echo "cmd : $cmd"
        eval $cmd

  fi
 
  if [ "$oper" = "delete" ];
  then

       cmd="kubectl delete -f $newFileName"
       echo "cmd : $cmd"
       eval $cmd
  fi
  noOfDeploy=$((noOfDeploy-1));
done

if [ "$oper" = "delete" ];
then
rm developer-copy-depl*
fi

#cmd='kubectl get pods | grep "developer-copy-depl*"'
#echo "cmd : $cmd"
#eval $cmd
echo " ******************************************************************************************* "
echo " Script run completed successfully. Please run below commands to check the deployments status"
echo " ******************************************************************************************* "
echo ""
echo " ********************* "
echo " kubectl get deploy  * "
echo " kubectl get pods    * "
echo " kubectl get svc     * "
echo " kubectl get pvc     * "
echo " ********************* "
