#!/bin/bash
echo
echo "Dirbust Controller v0.0.1"

echo "Killing previous instances of gobuster"
killall gobuster &

if [ ! -f "domains" ]; then
        echo "Create a `domains` file with full url(s) seperated by new lines to run your campaigns against"
        exit
fi

if [ ! -d "gobuster-results" ]; then
        mkdir gobuster-results
fi

for item in $(cat domains) ; do
        filename=$( echo $item | cut -d "/" -f3- );
        echo "gobuster-results/$filename"
        gobuster -w /usr/share/wordlists/fuzzdb/discovery/predictable-filepaths/filename-dirname-bruteforce/raft-large-directories-lowercase.txt -u $item -t 100 > gobuster-results/$filename &
done
