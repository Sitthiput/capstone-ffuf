#!/bin/bash

target="$1"

# Add /FUZZ if it is missing in the target
echo "Target URL: $target"
if [[ $target != *"FUZZ"* ]]; then
    echo $target | grep '/$'
    if [ $? -eq 1 ]; then
        target="${target}/"
    fi
    target="${target}FUZZ"
    echo "Changed target URL to: $target"
fi

set -x

# Scan
ffuf -w words_and_files_top5000.txt \
    -u $target \
    -H "X-Scanner: FFUF" \
    -of all \
    -o /var/reports/ffuf_scan \
    -ac \
    -mc 200 \
    -r \
    ${@:2}

# Parse the report
python3 ffuf.py
