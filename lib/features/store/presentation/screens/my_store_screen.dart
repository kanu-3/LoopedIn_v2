import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/products/providers/providers/product_provider.dart';

class MyStoreScreen extends ConsumerStatefulWidget {
  const MyStoreScreen({super.key});

  @override
  ConsumerState<MyStoreScreen> createState() => _MyStoreScreenState();
}

class _MyStoreScreenState extends ConsumerState<MyStoreScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(productProvider.notifier).fetchMyProducts();
      ref.read(productProvider.notifier).fetchDashboardAnalytics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);
    final maxChartValue = productState.weeklyChartData.values.fold<int>(0, (max, e) => e > max ? e : max);

    final int totalSold = productState.myProducts.where((p) => p.status == 'sold').length;
    final int totalRented = productState.myProducts.where((p) => p.status == 'rented').length;

    return Scaffold(
      backgroundColor: AppColors.whitetext,
      appBar: const AppHeader(title: 'My Store'),
      body: SingleChildScrollView(
        padding: context.bodypad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back!',
              style: AppTextTheme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),

            Container(
              padding: context.padAllXS,
              decoration: BoxDecoration(
                color: AppColors.whitetext,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Listings This Week',
                    style: AppTextTheme.textTheme.headlineSmall?.copyWith(
                      color: CoreColors.grey700,
                    ),
                  ),
                  SizedBox(height: context.scaleH(24)),
                  SizedBox(
                    height: context.scaleH(240),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: productState.weeklyChartData.entries.map((entry) {
                        final double barHeightPercentage = maxChartValue > 0 ? (entry.value / maxChartValue) : 0.0;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 24,
                                  height: (barHeightPercentage * 120).clamp(6.0, 120.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.main,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: context.scaleH(8)),
                            Text(
                              entry.key,
                              style: AppTextTheme.textTheme.bodySmall,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: context.padAllXS,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Wishlist', style: AppTextTheme.textTheme.titleSmall?.copyWith(
                          color: CoreColors.grey700,
                        )),
                        const SizedBox(height: 8),
                        Text(
                          '${productState.wishlistCount}',
                          style: AppTextTheme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: context.scaleW(12)),
                Expanded(
                  child: Container(
                    padding: context.padAllXS,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('My Products', style: AppTextTheme.textTheme.titleSmall?.copyWith(
                          color: CoreColors.grey700,
                        )),
                        const SizedBox(height: 8),
                        Text(
                          '${productState.myProducts.length}',
                          style: AppTextTheme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: context.padAllXS,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Sold', style: AppTextTheme.textTheme.titleSmall?.copyWith(
                          color: CoreColors.grey700,
                        )),
                        const SizedBox(height: 8),
                        Text(
                          '$totalSold',
                          style: AppTextTheme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: context.scaleW(12)),
                Expanded(
                  child: Container(
                    padding: context.padAllXS,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Rented', style: AppTextTheme.textTheme.titleSmall?.copyWith(
                          color: CoreColors.grey700,
                        )),
                        const SizedBox(height: 8),
                        Text(
                          '$totalRented',
                          style: AppTextTheme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.scaleH(32)),

            AppButton(
              width: double.infinity,
              text: 'My Products',
              onPressed: () {
                context.push('/my-products');
              },
            ),
          ],
        ),
      ),
    );
  }
}