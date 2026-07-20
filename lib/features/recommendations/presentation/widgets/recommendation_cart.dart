import 'package:flutter/material.dart';

import '../../data/models/recommendation_model.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.recommendation,
  });

  final RecommendationModel recommendation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Expanded(
            flex: 6,
            child: Image.network(
              recommendation.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.image),
            ),
          ),

          Expanded(
            flex: 5,
            child: Padding(
              padding:
              const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    recommendation.title,
                    maxLines: 2,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    recommendation.brand,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [

                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        recommendation.rating
                            .toString(),
                      ),

                      const Spacer(),

                      Text(
                        "₹${recommendation.currentPrice.toInt()}",
                        style:
                        const TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}