from fastapi import APIRouter, Body, Response
from app.schemas import Fuzz_input
from starlette.responses import JSONResponse
import logging, os, json

router = APIRouter()
REPORT_FOLDER = '/code/app/reports'

def load_json():
    f = open(REPORT_FOLDER + '/result.json')
    data = json.load(f)
    return data

def clear_reports():
    for file_name in os.listdir(REPORT_FOLDER):
        file_path = os.path.join(REPORT_FOLDER, file_name)
        try:
            os.unlink(file_path)
        except Exception as e:
            print(f'Failed to delete {file_path}. Reason: {e}')

@router.post("/scan", status_code=200)
def test(req_body: Fuzz_input = Body(...)) -> Response:
    try:
        if req_body:
            url = req_body.url
            clear_reports()

            os.system(f'/bin/sh -c "/code/app/ffuf/start.sh {url}"')

            data = load_json()
            result = {
                'message': 'Directories / Files found by fuzzing',
                'total': 0,
                'data': []
            }

            for obj in data['vulnerabilities']:
                tmp = {'url': obj['url'], 'content-type': obj['content-type']}
                result['data'].append(tmp)
                result['total'] += 1

            return JSONResponse(
                status_code = 200,
                content = result
            )
        else:
            return JSONResponse(
                status_code = 400,
                content = {
                    "message": "Invalid Request"
                }
            )
    except Exception as e:
        logging.error(e)
        return JSONResponse(
            status_code = 400,
            content = {
                "message": "error"
            }
        )
