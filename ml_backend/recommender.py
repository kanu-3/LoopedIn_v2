import pickle
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity

with open("tfidf_vectorizer.pkl", "rb") as f:
    tfidf = pickle.load(f)

with open("recommendation_data.pkl", "rb") as f:
    df = pickle.load(f)
    
print(df.index)
print(df.shape)

tfidf_matrix = tfidf.transform(df["combined_features"])


def recommend(title, brand, category, size):
    query = f"{title} {brand} {category} {size}"

    query_vector = tfidf.transform([query])

    similarity = cosine_similarity(query_vector, tfidf_matrix).flatten()

    valid_indices = np.where(similarity > 0.20)[0]

    ratings = df["rating"]
    normalized_rating = (ratings - ratings.min()) / (
        ratings.max() - ratings.min()
    )

    final_score = 0.85 * similarity + 0.15 * normalized_rating

    top = valid_indices[np.argsort(final_score[valid_indices])[::-1]][:5]

    return df.iloc[top][
        ["title", "brand", "category", "current_price", "rating", "image_url"]
    ].to_dict(orient="records")