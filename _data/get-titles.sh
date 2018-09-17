#!/bin/sh
echo '-----------------'
echo 'Retrieving titles'
echo '-----------------'

while read url;
do
	#echo $url;
	curl -L "$url" | grep '<title>';
done < resource-urls.csv
