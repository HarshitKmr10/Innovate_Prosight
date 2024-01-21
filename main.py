from fastapi import *
from typing import List, Optional
# from utils import *
from schema import *
from fastapi.openapi.utils import get_openapi
from transcription.utilities import *
from starlette.middleware import Middleware
from starlette.middleware.cors import CORSMiddleware
import os

origins = [
    "*",
    "http://localhost:5173",
    os.environ.get("CLIENT_URL")
]
middleware = [
    Middleware(CORSMiddleware, allow_origins=origins, allow_methods="*")
]
app = FastAPI(debug = True, middleware=middleware)


@app.get("/", include_in_schema=False)
async def root():
    """
    Root endpoint
    """
    return {"message": "Use /docs"}


@app.get("/hello/{name}", include_in_schema=False)
async def say_hello(name: str):
    return {"message": f"Hello {name}"}

@app.post("/audio/transcribe/file/")
async def audio_transcribe(file: UploadFile = File(...), language: Optional[str] = "auto"):
    print(language)
    contents = await file.read()
    fname = file.filename
    fname = os.path.join(os.getcwd(), fname)
    with open(fname, "wb") as f:
        f.write(contents)
    trans_ = transcribe(fname)
    os.remove(fname)
    return trans_

@app.post("/audio/transcribe/multiple/")
async def audio_transcribe_multiple(files: List[UploadFile] = File(...)):
    f_contents = [await f.read() for f in files]
    fnames = [f.filename for f in files]
    fnames = [os.path.join(os.getcwd(), fname) for fname in fnames]
    transcriptions = []
    for i in range(len(fnames)):
        with open(fnames[i], 'wb') as f:
            f.write(f_contents[i])
        transcriptions.append(transcribe(fnames[i]))
        os.remove(fnames[i])
    return transcriptions

@app.post("/audio/summary/")
async def audio_summary(file: UploadFile = File(...)):
    contents = await file.read()
    fname = file.filename
    fname = os.path.join(os.getcwd(), fname)
    with open(fname, "wb") as f:
        f.write(contents)
    summary = summarize_audio(fname)
    os.remove(fname)
    return summary

@app.post("/audio/sentiment/")
async def audio_summary(file: UploadFile = File(...)):
    contents = await file.read()
    fname = file.filename
    fname = os.path.join(os.getcwd(), fname)
    with open(fname, "wb") as f:
        f.write(contents)
    sentiment = sentiment_audio(fname)
    os.remove(fname)
    return sentiment

@app.post("/audio/search/")
async def audio_search(files : List[UploadFile] = File(...), query: str = Form(...)):
    f_contents = [await f.read() for f in files]
    fnames = [f.filename for f in files]
    fnames = [os.path.join(os.getcwd(), fname) for fname in fnames]
    for i in range(len(fnames)):
        with open(fnames[i], 'wb') as f:
            f.write(f_contents[i])
    answer, audio = search(fnames, query)
    return {
        "answer": answer,
        "audio": audio
    }

@app.post("/audio/qna/")
async def audio_qna(files : List[UploadFile] = File(...), query: str = Form(...)):
    f_contents = [await f.read() for f in files]
    fnames = [f.filename for f in files]
    fnames = [os.path.join(os.getcwd(), fname) for fname in fnames]
    for i in range(len(fnames)):
        with open(fnames[i], 'wb') as f:
            f.write(f_contents[i])

    answer = QnA(fnames, query)
    return answer

@app.post("/text/translate/")
async def text_translate(request: Translate):
    request_json = eval(request.model_dump_json())
    # print(request_json)
    output_language = request_json["output_language"]
    text = request_json["text"]
    translated_text = translate(text, output_language)
    return translated_text

@app.post("/text/summary/")
async def text_summary(text: str = Form(...)):
    summary = summarize_text(text)
    return summary

@app.post("/text/sentiment/")
async def text_sentiment(text: str = Form(...)):
    sentiment = sentiment_text(text)
    return sentiment

@app.post("/text/qna/")
async def text_qna(text: str = Form(...), query: str = Form(...)):
    answer = QnA_text(text, query)
    return answer

@app.get("/openapi.json", include_in_schema=False)
async def get_open_api_endpoint():
    return JSONResponse(get_openapi(title="Swagger Documentation", version="1.0", routes=app.routes))
