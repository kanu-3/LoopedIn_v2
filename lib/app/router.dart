import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/app/app_shell.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/features/auth/presentation/screens/login_screen.dart';
import 'package:loopedin_v2/features/auth/presentation/screens/signup_screen.dart';
import 'package:loopedin_v2/features/categories/presentation/screens/subcategory_products_screen.dart';
import 'package:loopedin_v2/features/categories/presentation/screens/women_subcategory_screen.dart';
import 'package:loopedin_v2/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:loopedin_v2/features/chat/presentation/screens/chat_room_screen.dart';
import 'package:loopedin_v2/features/onboarding/presentation/screens/decision_screen.dart';
import 'package:loopedin_v2/features/onboarding/presentation/screens/intro_screen.dart';
import 'package:loopedin_v2/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:loopedin_v2/features/home/presentation/screens/home_screen.dart';
import 'package:loopedin_v2/features/orders/data/models/cart_item_model.dart';
import 'package:loopedin_v2/features/orders/data/models/offer_model.dart';
import 'package:loopedin_v2/features/orders/data/models/order_model.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/cart_screen.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/checkout_screen.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/offer_detail_screen.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/offer_screen.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/order_details_screen.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/orders_screen.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/paymentmethod_screen.dart';
import 'package:loopedin_v2/features/products/presentation/screens/my_product_screens.dart';
import 'package:loopedin_v2/features/products/presentation/screens/product_details_screen.dart';
import 'package:loopedin_v2/features/products/presentation/screens/products_preview_screen.dart';
import 'package:loopedin_v2/features/profile/presentation/screens/complete_profile_screen.dart';
import 'package:loopedin_v2/features/profile/presentation/screens/my_account_screen.dart';
import 'package:loopedin_v2/features/profile/presentation/screens/profile_screen.dart';
import 'package:loopedin_v2/features/categories/presentation/screens/category_screen.dart';
import 'package:loopedin_v2/features/products/presentation/screens/add_product_screen.dart';
import 'package:loopedin_v2/features/profile/presentation/screens/user_profile_screen.dart';
import 'package:loopedin_v2/features/recommendations/presentation/screens/recommendation_screen.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_model.dart';
import 'package:loopedin_v2/features/sos/presentation/screens/accepted_users_screen.dart';
import 'package:loopedin_v2/features/sos/presentation/screens/create_sos_screen.dart';
import 'package:loopedin_v2/features/sos/presentation/screens/my_sos_screen.dart';
import 'package:loopedin_v2/features/sos/presentation/screens/sos_details_screen.dart';
import 'package:loopedin_v2/features/sos/presentation/screens/sos_feed_screen.dart';
import 'package:loopedin_v2/features/sos/presentation/screens/sos_status_screen.dart';
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
            builder: (context, state) => const ChatListScreen(),
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

        final total = (extra["total"] as num).toDouble();

        final rawItems = extra["items"] as List<dynamic>? ?? [];
        final items = rawItems.cast<CartItemUIModel>();

        return CheckoutScreen(
          total: total,
          items: items,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.payment,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final total = (extra["total"] as num).toDouble();
        final rawItems = extra["items"] as List<dynamic>? ?? [];
        final items = rawItems.cast<CartItemUIModel>();

        return PaymentMethodScreen(
          total: total,
          items: items,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.orders,
      builder: (context, state) => const OrdersScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.offers,
      builder: (context, state) => const OffersScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.recommendations,
      builder: (context, state) => const RecommendationScreen(),
    ),

    GoRoute(
      path: RoutePaths.offerdetails,
      builder: (context, state) {
        final offer = state.extra as OfferModel;

        return OfferDetailScreen(
          offer: offer,
        );
      },
    ),

    GoRoute(
      path: RoutePaths.orderdetails,
      builder: (context, state) {
        final order = state.extra as OrderModel;

        return OrderDetailScreen(
          order: order,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/chat/:roomId',
      builder: (context, state) {
        final roomId = state.pathParameters['roomId']!;
        final extra = state.extra as Map<String, dynamic>?;

        return ChatRoomScreen(
          roomId: roomId,
          otherUser: extra?['otherUser'],
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.sosStatus,
      builder: (context, state) {
        final sos = state.extra as SosModel;
        return SosStatusScreen(sos: sos);
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.createSos,
      builder: (context, state) => const CreateSosScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.sosDetails,
      builder: (context, state) {
        final sos = state.extra as SosModel;
        return SosDetailsScreen(sos: sos);
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.sosFeed,
      builder: (context, state) => const SosFeedScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.mySos,
      builder: (context, state) => const MySosScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RoutePaths.acceptedUsers,
      builder: (context, state) {

        debugPrint("Extra = ${state.extra}");

        final sos = state.extra as SosModel;

        return AcceptedUsersScreen(sos: sos);
      },
    ),
  ],
);