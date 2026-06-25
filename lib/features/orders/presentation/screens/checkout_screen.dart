import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/profile/presentation/widgets/address_edit_overlay.dart';
import 'package:loopedin_v2/features/profile/providers/provider/profile_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  final double total;

  const CheckoutScreen({
    super.key,
    required this.total,
  });

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  @override
  void initState() {
    super.initState();

    final userId = SupabaseService.client.auth.currentUser?.id;

    if (userId != null) {
      Future.microtask(() {
        ref.read(profileProvider.notifier).loadProfile(userId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final profile = state.profile;

    final userId = SupabaseService.client.auth.currentUser?.id;

    return Scaffold(
      appBar: const AppHeader(
        title: "Checkout",
        showBackButton: true,
      ),

      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())

          : profile == null
          ? const Center(child: Text("No profile found"))

          : Padding(
        padding: EdgeInsets.all(context.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: context.bodypad,
              decoration: BoxDecoration(
                borderRadius: context.borderRadiusM,
                color: AppColors.whitetext,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: CoreColors.grey400,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Address",
                        style: AppTextTheme.textTheme.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {
                          AddressEditOverlay.show(
                            context,
                            userId: userId!,
                            onSave: ({
                              required String table,
                              required String column,
                              required dynamic value,
                            }) async {
                              final success = await ref
                                  .read(profileProvider.notifier)
                                  .updateField(
                                table: table,
                                column: column,
                                value: value,
                              );

                              return success;
                            },
                          );
                        },
                        child: const Text("Change"),
                      ),
                    ],
                  ),

                  context.gapXS,

                  Text(
                    profile.defaultAddress.isEmpty
                        ? "No address added"
                        : profile.defaultAddress,
                    style: AppTextTheme.textTheme.bodyMedium
                  ),
                ],
              ),
            ),

            context.gapM,

            Container(
              padding: EdgeInsets.all(context.spacingM),
              decoration: BoxDecoration(
                color: AppColors.whitetext,
                borderRadius: context.borderRadiusM,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: CoreColors.grey400,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Total",
                    style: AppTextTheme.textTheme.headlineSmall
                  ),
                  Text(
                    "₹${widget.total.toStringAsFixed(2)}",
                    style: AppTextTheme.textTheme.headlineSmall
                  ),
                ],
              ),
            ),

            const Spacer(),

            AppButton(
              width: double.infinity,
              text: "Proceed to Payment",
              onPressed: () {
                context.push(
                  RoutePaths.payment,
                  extra: {"total": widget.total},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}