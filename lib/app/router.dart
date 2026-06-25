import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/app/app_shell.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/features/auth/presentation/screens/login_screen.dart';
import 'package:loopedin_v2/features/auth/presentation/screens/signup_screen.dart';
import 'package:loopedin_v2/features/categories/presentation/screens/subcategory_products_screen.dart';
import 'package:loopedin_v2/features/categories/presentation/screens/women_subcategory_screen.dart';
import 'package:loopedin_v2/features/onboarding/presentation/screens/decision_screen.dart';
import 'package:loopedin_v2/features/onboarding/presentation/screens/intro_screen.dart';
import 'package:loopedin_v2/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:loopedin_v2/features/home/presentation/screens/home_screen.dart';
import 'package:loopedin_v2/features/orders/data/models/cart_item_model.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/cart_screen.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/checkout_screen.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/paymentmethod_screen.dart';
import 'package:loopedin_v2/features/products/presentation/screens/my_product_screens.dart';
import 'package:loopedin_v2/features/products/presentation/screens/product_details_screen.dart';
import 'package:loopedin_v2/features/products/presentation/screens/products_preview_screen.dart';
import 'package:loopedin_v2/features/profile/presentation/screens/complete_profile_screen.dart';
import 'package:loopedin_v2/features/profile/presentation/screens/my_account_screen.dart';
import 'package:loopedin_v2/features/profile/presentation/screens/profile_screen.dart';
import 'package:loopedin_v2/features/categories/presentation/screens/category_screen.dart';
import 'package:loopedin_v2/features/chat/presentation/screens/chat_screen.dart';
import 'package:loopedin_v2/features/products/presentation/screens/add_product_screen.dart';
import 'package:loopedin_v2/features/profile/presentation/screens/user_profile_screen.dart';
import 'package:loopedin_v2/features/store/presentation/screens/my_store_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: RoutePaths.splash,
  routes: [
    GoRoute(
      path: RoutePaths.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePaths.onboarding,
      builder: (context, state) => const IntroScreen(),
    ),
    GoRoute(
      path: RoutePaths.decision,
      builder: (context, state) => const DecisionScreen(),
    ),
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.signup,
      builder: (context, state) => const SignupScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) {
        return AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: RoutePaths.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RoutePaths.categories,
          builder: (context, state) => const CategoryScreen(),
        ),
        GoRoute(
          path: RoutePaths.store,
          builder: (context, state) => const MyStoreScreen(),
        ),
        GoRoute(
          path: RoutePaths.chat,
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: RoutePaths.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.myProducts,
      builder: (context, state) => const MyProductsScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.addProduct,
      builder: (context, state) => const AddProductScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.editProduct,
      builder: (context, state) {
        return AddProductScreen(
          product: state.extra as ProductModel,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.productPreview,
      builder: (context, state) {
        final draft = state.extra as dynamic;
        return ProductPreviewScreen(draft: draft);
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.womenSubCategories,
      builder: (context, state) => const WomenSubCategoryScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.subCategoryProducts,
      builder: (context, state) {
        return SubCategoryProductsScreen(
          subCategory: state.extra as String,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.myAccount,
      builder: (context, state) => const MyAccountScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.completeProfile,
      builder: (context, state) => const CompleteProfileScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.userProfile,
      builder: (context, state) {
        return UserProfileScreen(
          sellerId: state.extra as String,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.productDetails,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final product = extra["product"] as ProductModel;

        return ProductDetailsScreen(product: product);
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.cart,
      builder: (context, state) => const CartScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.checkout,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final total = extra["total"] as double;

        return CheckoutScreen(total: total);
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.payment,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        final total = extra["total"] as double;
        final items = (extra["items"] as List<dynamic>?)
            ?.cast<CartItemUIModel>() ??
            [];

        return PaymentMethodScreen(
          total: total,
          items: items,
        );
      },
    ),
  ],
);