#!/bin/bash

cat live.txt | gau | grep ".js" | tee jslinks.txt
cat live.txt | waybackurls | grep ".js" | tee -a jslinks.txt
cat live.txt | subjs | tee -a jslinks.txt
cat live.txt | katana -jc | grep ".js" | tee -a jslinks.txt
waymore -i live.txt -mode U | grep ".js" | tee -a jslinks.txt
cat jslinks.txt | uniq | tee jslinks.txt

cat jslinks.txt | httpx | jslive.txt

echo "= parsing the js file through nuclei ="
nuclei -l jslinks.txt -t /root/nuclei-templates/http/exposures/ -o js_bugs.txt

echo "= parsing the js file through secretfinder ="
cat jslinks.txt  | while read url; do python3 /home/tools/secretfinder/SecretFinder.py -i $url -o cli; done
