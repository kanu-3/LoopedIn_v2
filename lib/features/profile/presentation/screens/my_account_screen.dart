import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/services/image_picker_service.dart';
import 'package:loopedin_v2/features/auth/providers/auth_provider.dart';
import 'package:loopedin_v2/features/profile/presentation/widgets/account_tile.dart';
import 'package:loopedin_v2/features/profile/presentation/widgets/stat_card.dart';
import 'package:flutter/foundation.dart';
import 'package:loopedin_v2/features/profile/providers/provider/profile_provider.dart';

class MyAccountScreen extends ConsumerWidget {
  const MyAccountScreen({super.key});

  Future<void> _handleImageSelection(
      BuildContext context,
      WidgetRef ref,
      ) async {
    final Uint8List? imageBytes =
    await ImagePickerService.pickSingleImage();
    print("IMAGE PICKED: ${imageBytes?.length}");

    if (imageBytes == null) return;

    await ref
        .read(profileProvider.notifier)
        .uploadProfilePicture(
      imageBytes,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    if (profileState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (profileState.error != null) {
      return Scaffold(
        body: Center(child: Text(profileState.error!)),
      );
    }

    final profile = profileState.profile;

    if (profile == null) {
      return const Scaffold(
        body: Center(child: Text("Profile not found")),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.main,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned(
              top: context.spacingL,
              left: context.spacingS,
              child: IconButton(
                icon: Icon(AssetPaths.back, color: AppColors.whitetext),
                onPressed: () => context.go(RoutePaths.home),
              ),
            ),

            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: context.scaleH(200)),

                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.whitetext,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Padding(
                      padding: context.bodypad,
                      child: Transform.translate(
                        offset: const Offset(0, -64),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => _handleImageSelection(context, ref),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: context.spacingLL*2.2,
                                    backgroundColor: CoreColors.grey200,
                                    backgroundImage: profile.profilePic != null
                                        ? NetworkImage(profile.profilePic!)
                                        : null,
                                    child: profile.profilePic == null
                                        ? Text(
                                      profile.name.isNotEmpty
                                          ? profile.username[0].toUpperCase()
                                          : "U",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    )
                                        : null,
                                  ),
                                  Container(
                                    padding: context.padAllXS,
                                    decoration:  BoxDecoration(
                                      color: AppColors.main,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      AssetPaths.check,
                                      color: AppColors.whitetext,
                                      size: context.spacingS,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profile.name.isNotEmpty ? profile.name : "Kanishka jha",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blacktext,
                                  ),
                                ),
                                SizedBox(width: context.scaleW(8)),
                                Icon(AssetPaths.edit, color: CoreColors.grey700, size: 22),
                              ],
                            ),

                            SizedBox(height: context.scaleH(20),),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: StatCard(
                                      label: "Sold",
                                      value: profile.soldListings
                                  ),
                                ),
                                Expanded(
                                  child: StatCard(
                                      label: "Active",
                                      value: profile.activeListings
                                  ),
                                ),
                                Expanded(
                                  child: StatCard(
                                      label: "Rented",
                                      value: profile.rentedListings
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: context.scaleH(24),),

                            AccountTile(
                              title: "My profile",
                              leading: Icon(AssetPaths.person),
                              onTap: () {
                                context.push(
                                  RoutePaths.completeProfile,
                                );
                              },
                            ),
                            AccountTile(
                              title: "Emergency",
                              leading: Icon(AssetPaths.emergency),
                              onTap: () {},
                            ),
                            AccountTile(
                              title: "Donate",
                              leading: Icon(AssetPaths.donate),
                              onTap: () {},
                            ),
                            AccountTile(
                              title: "My orders",
                              leading: Icon(AssetPaths.order),
                              onTap: () {},
                            ),
                            AccountTile(
                              title: "Settings",
                              leading: Icon(AssetPaths.settings),
                              onTap: () {},
                            ),
                            AccountTile(
                              title: "Help Center",
                              leading: const Icon(AssetPaths.help),
                              onTap: () {},
                            ),
                            AccountTile(
                              title: "Privacy policy",
                              leading: Icon(AssetPaths.lock),
                              onTap: () {},
                            ),
                            AccountTile(
                              title: "My Rewards",
                              leading: Icon(AssetPaths.reward),
                              onTap: () {},
                            ),
                            AccountTile(
                              title: "My wallet",
                              leading: Icon(AssetPaths.wallet),
                              onTap: () {},
                            ),
                            AccountTile(
                              title: "Log out",
                              leading: Icon(AssetPaths.logout),
                              onTap: () async {
                                await ref.read(authProvider.notifier).logout();
                                context.go('/login');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
