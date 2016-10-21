#!/bin/sh
BUCKETNAME=xxx; 
REGION=ap-southeast-2; 

while getopts "b:" opts; do
   case ${opts} in
      "b") BUCKETNAME=${OPTARG} ;;
   esac
done

echo "Bucket: $BUCKETNAME";
for prefix in $(aws s3api list-objects --bucket $BUCKETNAME --delimiter '/' --output text --region $REGION |grep COMMONPREFIX |tail -n+0| awk '{print $2}'); 
do 
	echo "Totals for $prefix"; 
	aws s3 ls --summarize --human-readable --recursive s3://$BUCKETNAME/$prefix --region $REGION; 
done | grep Total
