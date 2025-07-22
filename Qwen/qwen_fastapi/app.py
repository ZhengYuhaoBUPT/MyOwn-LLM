from fastapi import FastAPI
from pydantic import BaseModel
from model_infer import generate_answer

app = FastAPI()

class Query(BaseModel):
    question: str

@app.post("/ask")
def ask(q: Query):
    reply = generate_answer(q.question)
    return {"answer": reply}
