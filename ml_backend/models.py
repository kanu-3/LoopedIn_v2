from typing import Annotated
from pydantic import BaseModel, Field


class RecommendationRequest(BaseModel):
    title: Annotated[str,Field(min_length=1, max_length=100, example="Floral Dress")]

    brand: Annotated[str,Field(min_length=1,  example="H&M")]

    category: Annotated[str,Field(min_length=1, example="Women")]

    size: Annotated[str,Field(min_length=1, max_length=10, example="M")]