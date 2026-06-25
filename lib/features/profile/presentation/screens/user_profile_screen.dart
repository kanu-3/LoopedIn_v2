import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/products/product_card.dart';
import 'package:loopedin_v2/features/products/providers/providers/product_provider.dart';
import 'package:loopedin_v2/features/products/providers/states/product_state.dart';
import 'package:loopedin_v2/features/profile/presentation/widgets/user_profile_header.dart';
import 'package:loopedin_v2/features/profile/providers/provider/seller_profile_provider.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String sellerId;
  const UserProfileScreen({super.key, required this.sellerId});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(sellerProfileProvider.notifier).loadSeller(widget.sellerId);
      ref.read(productProvider.notifier).fetchProductsBySeller(widget.sellerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sellerState = ref.watch(sellerProfileProvider);
    final productState = ref.watch(productProvider);

    final String appBarTitle = sellerState.isLoading
        ? "Loading..."
        : (sellerState.profile?.username.isNotEmpty == true
        ? "@${sellerState.profile!.username}"
        : "Profile");

    return Scaffold(
      appBar: AppHeader(
        title: appBarTitle,
        showBackButton: true,
      ),
      body: sellerState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : sellerState.profile == null
          ? const Center(child: Text("Unable to load profile"))
          : SingleChildScrollView(
        child: Column(
          children: [
            UserProfileHeaderWidget(
              profile: sellerState.profile!,
              onFollow: () {
                ref.read(sellerProfileProvider.notifier).toggleFollow();
              },
              onMessage: () {},
            ),
            _buildProducts(productState),
          ],
        ),
      ),
    );
  }

  Widget _buildProducts(ProductState state) {
    if (state.isLoadingSellerProducts) return const Center(child: CircularProgressIndicator());
    if (state.sellerProducts.isEmpty) {
      return const AppEmptyWidget(
        title: "No Listings",
        subtitle: "This user has not listed any products.",
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: context.bodypad,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: context.spacingS,
        mainAxisSpacing: context.spacingS,
        childAspectRatio: .68,
      ),
      itemCount: state.sellerProducts.length,
      itemBuilder: (context, index) => ProductCard(product: state.sellerProducts[index], onTap: () {}),
    );
  }
}