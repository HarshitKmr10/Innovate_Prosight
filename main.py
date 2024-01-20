from transformers import pipeline
from fastapi import FastAPI


app = FastAPI()

model_name = "valurank/distilroberta-clickbait"

classifier = pipeline("text-classification", model=model_name)


@app.post("/classify")
async def classify(text: str):
    result = classifier(text)
    return result


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
