import csv, json, logging

data = {
    "vulnerabilities": []
}

report_path = "/var/reports/ffuf.json"

try:
    with open('/var/reports/ffuf_scan.csv', 'r') as file:
        report_reader = csv.reader(file)
        next(report_reader)

        for row in report_reader:
            data['vulnerabilities'].append({
                'Title': 'Directory / File Detected',
                'Description': row[1],
                'Severity': 'medium'
            })
    
    with open(report_reader, 'w') as out:
        json.dump(data, out)
except FileNotFoundError:
    logging.error('Scan report not found')