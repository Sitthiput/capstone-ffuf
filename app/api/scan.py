from fastapi import APIRouter, Body, Response
from app.schemas import Fuzz_input
from starlette.response import JSONResponse
import logging

router = APIRouter()

@router.post("/scan", status_code=200)
def scan(req_body: Fuzz_input = Body(...)) -> Response:
    try:
        if req_body:
            return JSONResponse(
                status_code = 200,
                content = {
                    "message": "Success"
                }
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
