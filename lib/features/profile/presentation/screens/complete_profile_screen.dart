import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/features/profile/presentation/widgets/address_edit_overlay.dart';
import 'package:loopedin_v2/features/profile/presentation/widgets/profile_details_tile.dart';
import 'package:loopedin_v2/features/profile/presentation/widgets/profile_edit_overlay.dart';
import 'package:loopedin_v2/features/profile/providers/provider/profile_provider.dart';


class CompleteProfileScreen extends ConsumerWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final profile = profileState.profile;

    if (profile == null) {
      return const Scaffold(
        backgroundColor: AppColors.main,
        body: Center(child: CircularProgressIndicator(color: AppColors.whitetext)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.main,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(AssetPaths.back, color: AppColors.whitetext),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: context.bodypad,
        child: Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.whitetext, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: context.scale(64),
                      backgroundColor: CoreColors.grey200,
                      backgroundImage: profile.profilePic != null
                          ? NetworkImage(profile.profilePic!)
                          : null,
                      child: profile.profilePic == null
                          ? Text(
                        profile.username.isNotEmpty
                            ? profile.username[0].toUpperCase()
                            : "U",
                        style: AppTextTheme.textTheme.headlineMedium,
                      )
                          : null,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(8, 4),
                    child: Icon(
                      AssetPaths.star,
                      color: CoreColors.icon,
                      size: context.scale(40),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.scaleH(20)),

            Text(
              "Your profile details",
              textAlign: TextAlign.center,
              style: AppTextTheme.textTheme.titleLarge?.copyWith(
                color: AppColors.whitetext
              ),
            ),
            SizedBox(height: 24),

            ProfileDetailTile(
              label: "Name",
              value: profile.name.isNotEmpty ? profile.name : "Edit Name",
              leadingIcon: Icon(AssetPaths.person),
              onTap: () {
                ProfileEditOverlay.show(
                  context,
                  title: "Name",
                  initialValue: profile.name,
                  table: "user_profile",
                  column: "name",
                  onSave: ref.read(profileProvider.notifier).updateField,
                );
              },
            ),

            ProfileDetailTile(
              label: "Bio",
              value: profile.bio.isNotEmpty ? profile.bio : "Add a bio about yourself",
              leadingIcon: Icon(AssetPaths.bio),
              onTap: () {
                ProfileEditOverlay.show(
                  context,
                  title: "Bio",
                  initialValue: profile.bio,
                  table: "user_profile",
                  column: "bio",
                  onSave: ref.read(profileProvider.notifier).updateField,
                );
              },
            ),

            ProfileDetailTile(
              label: "Social media",
              value: profile.socialMediaHandle.isNotEmpty ? profile.socialMediaHandle : "Not added",
              leadingIcon: Icon(AssetPaths.social_media),
              onTap: () {
                ProfileEditOverlay.show(
                  context,
                  title: "Social Media Handle",
                  initialValue: profile.socialMediaHandle == 'Not added' ? '' : profile.socialMediaHandle,
                  table: "user_profile",
                  column: "social_media_handle",
                  onSave: ref.read(profileProvider.notifier).updateField,
                );
              },
            ),

            ProfileDetailTile(
              label: "Mobile number",
              value: profile.phoneNo.isNotEmpty ? profile.phoneNo : "Add phone number",
              leadingIcon: Icon(AssetPaths.mobile),
              onTap: () {
                ProfileEditOverlay.show(
                  context,
                  title: "Mobile Number",
                  initialValue: profile.phoneNo,
                  table: "users",
                  column: "phone_no",
                  onSave: ref.read(profileProvider.notifier).updateField,
                );
              },
            ),

            ProfileDetailTile(
              label: "Email",
              value: profile.email,
              leadingIcon: Icon(AssetPaths.mail),
              onTap: () {
                ProfileEditOverlay.show(
                  context,
                  title: "Email Address",
                  initialValue: profile.email,
                  table: "users",
                  column: "email",
                  onSave: ref.read(profileProvider.notifier).updateField,
                );
              },
            ),

            ProfileDetailTile(
              label: "Govt. ID Type",
              value: profile.govtIdType.isNotEmpty ? profile.govtIdType : "e.g., Aadhar, PAN",
              leadingIcon: Icon(AssetPaths.govt_id),
              onTap: () {
                ProfileEditOverlay.show(
                  context,
                  title: "Govt ID Type",
                  initialValue: profile.govtIdType == 'Not uploaded' ? '' : profile.govtIdType,
                  table: "user_verification",
                  column: "govt_id_type",
                  onSave: ref.read(profileProvider.notifier).updateField,
                );
              },
            ),

            ProfileDetailTile(
              label: "Govt. ID Number",
              value: "•••• •••• ••••",
              leadingIcon: Icon(AssetPaths.id),
              onTap: () {
                ProfileEditOverlay.show(
                  context,
                  title: "Govt ID Number",
                  initialValue: "",
                  table: "user_verification",
                  column: "govt_id_num",
                  onSave: ref.read(profileProvider.notifier).updateField,
                );
              },
            ),

            ProfileDetailTile(
              label: "Address Status",
              value: profile.defaultAddress,
              leadingIcon: Icon(AssetPaths.address),
              onTap: () {
                AddressEditOverlay.show(
                  context,
                  userId: profile.userId,
                  onSave: ref.read(profileProvider.notifier).updateField,
                );
              },
            ),

            ProfileDetailTile(
              label: "Facial verification",
              value: "False",
              leadingIcon: Icon(AssetPaths.tick),
              onTap: () {},
            ),

            ProfileDetailTile(
              label: "Bank details",
              value: profile.bankName,
              leadingIcon: Icon(AssetPaths.wallet),
              onTap: () {},
            ),

             SizedBox(height: context.scaleH(40)),
          ],
        ),
      ),
    );
  }
}