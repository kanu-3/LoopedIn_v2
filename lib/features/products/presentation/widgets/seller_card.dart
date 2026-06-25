import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/features/profile/providers/provider/seller_profile_provider.dart';

class SellerCard extends ConsumerStatefulWidget {
  const SellerCard({
    super.key,
    required this.sellerId,
  });

  final String sellerId;

  @override
  ConsumerState<SellerCard> createState() =>
      _SellerCardState();
}

class _SellerCardState
    extends ConsumerState<SellerCard> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(
        sellerProfileProvider.notifier,
      )
          .loadSeller(
        widget.sellerId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state =
    ref.watch(sellerProfileProvider);

    final seller = state.profile;

    if (seller == null) {
      return const SizedBox.shrink();
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
        seller.profilePic != null
            ? NetworkImage(
          seller.profilePic!,
        )
            : null,
      ),
      title: Text(seller.name),
      subtitle: Text(
        "@${seller.username}",
      ),
      trailing: AppButton(
        text: seller.isFollowing
            ? "Following"
            : "Follow",
        onPressed: () {
          ref
              .read(
            sellerProfileProvider
                .notifier,
          )
              .toggleFollow();
        },
      ),
      onTap: () {
        context.push(
          RoutePaths.userProfile,
          extra: seller.userId,
        );
      },
    );
  }
}