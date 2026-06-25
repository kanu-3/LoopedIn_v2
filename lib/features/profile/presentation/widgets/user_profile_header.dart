import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/profile_model.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/features/profile/presentation/widgets/stat_card.dart';

class UserProfileHeaderWidget extends StatelessWidget {
  final ProfileModel profile;
  final VoidCallback onFollow;
  final VoidCallback onMessage;

  const UserProfileHeaderWidget({
    super.key,
    required this.profile,
    required this.onFollow,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.bodypad,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: context.scaleH(76),
                backgroundImage: profile.profilePic != null
                    ? NetworkImage(profile.profilePic!)
                    : null,
                child: profile.profilePic == null
                    ? Text(
                  profile.username.isNotEmpty
                      ? profile.username[0].toUpperCase()
                      : "U",
                )
                    : null,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatCard(
                      label: "Followers",
                      value: profile.followers,
                    ),
                    StatCard(
                      label: "Following",
                      value: profile.following,
                    ),
                    StatCard(
                      label: "Active",
                      value: profile.activeListings,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Text(
            profile.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          context.gapXXS,
          Text(
            profile.bio.isNotEmpty ? profile.bio : "LoopedIn member",
            textAlign: TextAlign.center,
          ),

          context.gapXS,

          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: profile.isFollowing ? "Following" : "Follow",
                  onPressed: onFollow,
                ),
              ),
              SizedBox(width: context.scaleW(8),),
              Expanded(
                child: AppButton(
                  variant: ButtonVariant.white,
                  text: "Message",
                  onPressed: onMessage,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}