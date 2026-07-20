from fastapi import FastAPI
from models import RecommendationRequest
from recommender import recommend

app = FastAPI()


@app.get("/")
def home():
    return {"message": "LoopedIN recommendation API Running"}


@app.post("/recommend")
def get_recommendations(request: RecommendationRequest):
    recommendations = recommend(
        request.title,
        request.brand,
        request.category,
        request.size
    )

    return {"recommendations": recommendations}