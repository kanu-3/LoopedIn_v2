import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/dialogs/app_success_dialog.dart';
import 'package:loopedin_v2/core/widgets/dialogs/confirm_dialog.dart';
import 'package:loopedin_v2/features/orders/data/models/cart_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/features/orders/providers/notifiers/cart_notifier.dart';
import 'package:loopedin_v2/features/orders/providers/providers/order_provider.dart';
import 'package:loopedin_v2/features/profile/providers/provider/profile_provider.dart';

class PaymentMethodScreen extends ConsumerStatefulWidget {
  final double total;
  final List<CartItemUIModel> items;

  const PaymentMethodScreen({
    super.key,
    required this.total,
    required this.items,
  });

  @override
  ConsumerState<PaymentMethodScreen> createState() =>
      _PaymentMethodScreenState();
}

class _PaymentMethodScreenState
    extends ConsumerState<PaymentMethodScreen> {
  String? selectedMethod;

  final methods = const [
    "UPI",
    "Card",
    "Wallet",
    "Cash on Delivery",
  ];

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final profile = profileState.profile;

    return Scaffold(
      appBar: const AppHeader(
        title: "Payment",
        showBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(context.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Payment Method",
              style: AppTextTheme.textTheme.titleLarge,
            ),

            context.gapM,

            ...methods.map((method) {
              final isSelected = selectedMethod == method;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedMethod = method);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.main
                          : CoreColors.grey400,
                      width: isSelected ? 2 : 1,
                    ),
                    color: isSelected
                        ? AppColors.main.withOpacity(0.08)
                        : AppColors.whitetext,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? AssetPaths.checked_rounded
                            : AssetPaths.check_rounded,
                        color: isSelected
                            ? AppColors.main
                            : CoreColors.grey400,
                      ),
                      const SizedBox(width: 12),
                      Text(method),
                    ],
                  ),
                ),
              );
            }),

            const Spacer(),

            AppButton(
              width: double.infinity,
              text: "Confirm Payment",
              onPressed: () async {
                if (selectedMethod == null) {
                  AppSnackBar.show(
                    context,
                    message: "Select a payment method",
                    isError: true,
                  );
                  return;
                }

                if (profile == null) {
                  AppSnackBar.show(
                    context,
                    message: "Profile not found",
                    isError: true,
                  );
                  return;
                }

                final confirmed = await ConfirmDialog.show(
                  context: context,
                  title: "Confirm Payment",
                  message:
                  "Pay ₹${widget.total.toStringAsFixed(2)} using $selectedMethod?",
                  confirmText: "Pay Now",
                  cancelText: "Cancel",
                );

                if (confirmed != true || !mounted) return;

                final orderNotifier =
                ref.read(orderProvider.notifier);

                final success = await orderNotifier.placeOrder(
                  items: widget.items,
                  buyerName: profile.name,
                  buyerPhone: profile.phoneNo,
                  deliveryAddress: profile.defaultAddress,
                  totalPrice: widget.total,
                );
                await ref.read(cartProvider.notifier).loadCart();
                await ref.read(orderProvider.notifier).fetchBuyerOrders();
                await ref.read(orderProvider.notifier).fetchSellerOrders();
                if (!success) {
                  AppSnackBar.show(
                    context,
                    message: "Order failed. Try again.",
                    isError: true,
                  );
                  return;
                }

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogCtx) => AppSuccessDialog(
                    title: "Success",
                    subtitle:
                    "Your order has been placed successfully",
                    primaryText: "View Orders",
                    secondaryText: "Continue Shopping",
                    onPrimaryTap: () {
                      Navigator.pop(dialogCtx);
                      context.go(RoutePaths.orders);
                    },
                    onSecondaryTap: () {
                      Navigator.pop(dialogCtx);
                      context.go(RoutePaths.home);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}