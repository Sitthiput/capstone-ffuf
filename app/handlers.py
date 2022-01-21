from fastapi import FastAPI
from .api import scan

app = FastAPI()

app.include_router(
    scan.router,
    prefix="/api",
    response={404: {"message": "Not Found"}},
)