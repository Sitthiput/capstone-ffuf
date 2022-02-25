from pydantic import BaseModel

class Fuzz_input(BaseModel):
    url: str
    class Config:
        orm_mode = True