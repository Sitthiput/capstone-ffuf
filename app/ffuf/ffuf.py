import csv
import json
import logging

data = {
    "vulnerabilities": []
}

file_path = "/code/app/reports"

report_path = file_path + "/ffuf.json"

try:
    with open(file_path + '/ffuf_scan.csv', 'r') as csvfile:
        report_reader = csv.reader(csvfile)
        # Skip the header
        next(report_reader)
        for row in report_reader:
            data['vulnerabilities'].append({
                'title': 'Directory / File Detected',
                'description': row[1], # Full URL with fuzzed path
                'severity': "medium"
            })

    with open(report_path, 'w') as outfile:
        json.dump(data, outfile)
except FileNotFoundError:
    logging.error('Ffuf scan report not found')