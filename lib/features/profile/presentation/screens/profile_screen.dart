import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/products/product_card.dart';
import 'package:loopedin_v2/features/products/providers/providers/product_provider.dart';
import 'package:loopedin_v2/features/products/providers/states/product_state.dart';
import 'package:loopedin_v2/features/profile/presentation/widgets/profile_header.dart';
import 'package:loopedin_v2/features/profile/providers/provider/profile_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String? userId;
  const ProfileScreen({super.key, this.userId});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String? _profileUserId;
  bool _isCurrentUser = false;

  @override
  void initState() {
    super.initState();

    final currentUser = SupabaseService.client.auth.currentUser;
    _profileUserId = widget.userId ?? currentUser?.id;
    _isCurrentUser = _profileUserId == currentUser?.id;

    if (_profileUserId != null) {
      Future.microtask(() {
        ref.read(profileProvider.notifier).loadProfile(_profileUserId!);

        if (_isCurrentUser) {
          ref.read(productProvider.notifier).fetchMyProductsOnly();
        } else {
          ref.read(productProvider.notifier).fetchProductsBySeller(_profileUserId!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);
    final profileState = ref.watch(profileProvider);
    final profile = profileState.profile;

    return Scaffold(
      appBar: const AppHeader(
        title: "Profile",
        showCloseButton: false,
        showBackButton: false,
      ),
      body: profileState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileState.error != null
          ? Center(child: Text(profileState.error!))
          : SingleChildScrollView(
        child: Column(
          children: [
            if (profile != null)
              ProfileHeaderWidget(
                profile: profile,
                isCurrentUser: _isCurrentUser,
                onEdit: () => context.push(RoutePaths.myAccount),
                onFollow: () => ref.read(profileProvider.notifier).toggleFollow(),
                onMessage: () {},
              ),
            context.gapM,
            _buildProducts(productState),
          ],
        ),
      ),
    );
  }

  Widget _buildProducts(ProductState productState) {
    final products = _isCurrentUser ? productState.myProducts : productState.sellerProducts;
    final loading = _isCurrentUser ? productState.isLoadingMyProducts : productState.isLoadingSellerProducts;

    if (loading) return const Center(child: CircularProgressIndicator());
    if (products.isEmpty) {
      return const AppEmptyWidget(
        title: "No Listings Yet",
        subtitle: "Products will appear here.",
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
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(product: products[index], onTap: () {}),
    );
  }
}