#!/bin/bash

domain=$1
echo "$domain" | gau | grep ".js" | tee jslinks.txt
echo "$domain" | waybackurls | grep ".js" | tee -a jslinks.txt
echo "$domain" | subjs | tee -a jslinks.txt
cat jslinks.txt | uniq | tee jslinks.txt

cat jslinks.txt | httpx | jslive.txt
nuclei -l jslinks.txt -t /root/nuclei-templates/http/exposures/ -o js_bugs.txt
