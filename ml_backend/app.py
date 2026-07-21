from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from models import RecommendationRequest
from recommender import recommend

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

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