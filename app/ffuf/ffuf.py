import csv
import json
import logging

data = {
    "vulnerabilities": []
}

file_path = "/code/app/reports"

report_path = file_path + "/result.json"

try:
    with open(file_path + '/ffuf_scan', 'r') as csvfile:
        report_reader = csv.reader(csvfile)
        # Skip the header
        next(report_reader)
        for row in report_reader:
            data['vulnerabilities'].append({
                'title': 'Directory / File Detected',
                'url': row[1], # Full URL with fuzzed path
                'content-type': row[8],
            })

    with open(report_path, 'w') as outfile:
        json.dump(data, outfile)
except FileNotFoundError:
    logging.error('Ffuf scan report not found')