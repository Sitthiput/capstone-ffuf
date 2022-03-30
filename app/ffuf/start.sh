#!/bin/sh

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
/code/app/ffuf/ffuf -w /code/app/ffuf/words_and_files_top5000.txt \
    -u $target -ignore-body \
    -H "X-Scanner: FFUF" \
    -recursion -recursion-depth 5 \
    -mc all -ac \
    -fc 400,404,429 \
    -o /code/app/reports/ffuf_scan \
    -r \
    -of csv \
    ${@:2}

ls /code/app/reports
# Parse the report
python3 /code/app/ffuf/ffuf.py
