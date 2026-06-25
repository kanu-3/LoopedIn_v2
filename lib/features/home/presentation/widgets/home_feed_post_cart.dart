import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/features/home/data/models/home_feed_model.dart';

class HomeFeedPostCard extends StatelessWidget {
  const HomeFeedPostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onDislike,
    required this.onWishlist,
    required this.isLiked,
    required this.isDisliked,
    required this.isWishlisted,
  });

  final HomeFeedModel post;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onWishlist;
  final bool isLiked;
  final bool isDisliked;
  final bool isWishlisted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.spacingM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: context.borderRadiusM,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: GestureDetector(
              child: CircleAvatar(
                backgroundImage: post.sellerProfilePic != null
                    ? CachedNetworkImageProvider(
                  post.sellerProfilePic!,
                )
                    : null,
                child: post.sellerProfilePic == null
                    ? Icon(AssetPaths.person)
                    : null,
              ),
            ),
            title: Text(post.sellerName),
            subtitle: Text("@${post.sellerUsername}"),
            onTap: () {
              context.push(
                RoutePaths.userProfile,
                extra: post.sellerId,
              );
            },
          ),
          AspectRatio(
            aspectRatio: 1,
            child: post.product.images.isNotEmpty
                ? CachedNetworkImage(imageUrl: post.product.images.first, fit: BoxFit.cover)
                : Icon(AssetPaths.image),
          ),

          Padding(
            padding: context.padAllS,
            child: Row(
              children: [
                GestureDetector(
                  onTap: onLike,
                  child: Icon(
                    isLiked ? AssetPaths.liked : AssetPaths.like,
                    color: isLiked ? AppColors.main : AppColors.blacktext,
                  ),
                ),
                context.gapWXXS,
                Text(post.likesCount.toString()),
                context.gapWM,

                GestureDetector(
                  onTap: onDislike,
                  child: Icon(
                    isDisliked ? AssetPaths.disliked : AssetPaths.dislike,
                    color: isDisliked ? AppColors.dislike : AppColors.blacktext,
                  ),
                ),
                context.gapWM,

                Icon(AssetPaths.comment),
                context.gapWXXS,
                Text(post.commentsCount.toString()),

                const Spacer(),

                GestureDetector(
                  onTap: onWishlist,
                  child: Icon(
                    isWishlisted ? AssetPaths.wished : AssetPaths.wish,
                    color: isWishlisted ? AppColors.onError : AppColors.blacktext,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.spacingS),
            child: Text(post.product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.spacingS),
            child: Text(post.product.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
          context.gapS,
        ],
      ),
    );
  }
}