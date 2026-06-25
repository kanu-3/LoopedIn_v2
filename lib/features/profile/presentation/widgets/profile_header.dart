import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/profile_model.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/features/profile/presentation/widgets/stat_card.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final ProfileModel profile;
  final VoidCallback onEdit;
  final bool isCurrentUser;
  final VoidCallback? onFollow;
  final VoidCallback? onMessage;

  const ProfileHeaderWidget({
    super.key,
    required this.profile,
    required this.onEdit,
    required this.isCurrentUser,
    this.onFollow,
    this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.bodypad,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    StatCard(label: "Followers", value: profile.followers),
                    StatCard(label: "Following", value: profile.following),
                    StatCard(label: "Active", value: profile.activeListings)
                  ],
                ),
              )
          ],
          ),

          context.gapXS,

              Text(
                "@${profile.username}",
                style: Theme.of(context).textTheme.titleLarge,
              ),


          context.gapXS,

          Text(
            profile.bio.isNotEmpty ? profile.bio : "LoopedIn member",
            textAlign: TextAlign.center,
          ),

          context.gapXS,

          if (isCurrentUser)
            AppButton(
              width: double.infinity,
              variant: ButtonVariant.white,
              text: "Edit Profile",
              onPressed: onEdit,
            )
          else
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    width: double.infinity,
                    text: profile.isFollowing
                        ? "Following"
                        : "Follow",
                    onPressed: onFollow,
                  ),
                ),

                context.gapS,

                Expanded(
                  child: AppButton(
                    width: double.infinity,
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