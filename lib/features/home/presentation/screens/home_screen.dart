import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/features/home/presentation/widgets/home_feed_post_cart.dart';
import 'package:loopedin_v2/features/home/presentation/widgets/home_header.dart';
import 'package:loopedin_v2/features/home/presentation/widgets/home_search_bar.dart';
import 'package:loopedin_v2/features/home/presentation/widgets/user_search_overlay.dart';
import 'package:loopedin_v2/features/home/providers/home_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();


  final FocusNode _focusNode =
  FocusNode();

  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).initialize();
    });

    _focusNode.addListener(() {setState(() {
      _showOverlay = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {

    _searchController.dispose();
    _focusNode.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [

              Column(
                children: [

          HomeHeader(
          username: state.currentUserProfile?['name'] ?? 'User',
        ),

                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await ref
                            .read(homeProvider.notifier)
                            .refreshFeed();
                      },
                      child: SingleChildScrollView(
                        physics:
                        const AlwaysScrollableScrollPhysics(),

                        padding: context.padAllS,

                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            HomeSearchBar(
                              controller: _searchController,
                              onChanged: (value) {
                                ref
                                    .read(
                                  homeProvider.notifier,
                                )
                                    .searchUsers(value);
                              },
                            ),

                            context.gapM,

                            if (state.isLoading)
                              const Center(
                                child:
                                CircularProgressIndicator(),
                              ),

                            if (!state.isLoading)
                              ...state.feedPosts.map(
                                    (post) => HomeFeedPostCard(
                                  post: post,
                                  isLiked: state.likedProductIds.contains(post.product.id),
                                  isDisliked: state.locallyDislikedProductIds.contains(post.product.id),
                                  isWishlisted: state.wishlistedProductIds.contains(post.product.id), // Hooked back up!

                                  onLike: () {
                                    ref.read(homeProvider.notifier).toggleLike(post.product.id);
                                  },
                                  onDislike: () {
                                    ref.read(homeProvider.notifier).toggleDislike(post.product.id);
                                  },

                                  onWishlist: () {
                                    ref.read(homeProvider.notifier).toggleWishlist(post.product.id); // Hooked back up!
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              if (_showOverlay &&
                  state.searchedUsers.isNotEmpty)
                Positioned(
                  top: context.scale(180),
                  left: context.spacingS,
                  right: context.spacingS,
                  child: UserSearchOverlay(
                    users: state.searchedUsers,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }}