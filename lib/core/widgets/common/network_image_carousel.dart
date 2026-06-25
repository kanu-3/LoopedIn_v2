import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';

class NetworkImageCarousel extends StatefulWidget {
  const NetworkImageCarousel({
    super.key,
    required this.imageUrls,
    this.height = 420,
    this.borderRadius,
  });

  final List<String> imageUrls;
  final double height;
  final BorderRadius? borderRadius;

  @override
  State<NetworkImageCarousel> createState() =>
      _NetworkImageCarouselState();
}

class _NetworkImageCarouselState
    extends State<NetworkImageCarousel> {
  final PageController _pageController =
  PageController();

  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: const Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 40,
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            itemBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius:
                  widget.borderRadius ??
                      BorderRadius.zero,
                  child: CachedNetworkImage(
                    imageUrl:
                    widget.imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (_, __) =>
                    const Center(
                      child:
                      CircularProgressIndicator(),
                    ),
                    errorWidget: (_, __, ___) =>
                    const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        if (widget.imageUrls.length > 1) ...[
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: List.generate(
              widget.imageUrls.length,
                  (index) {
                final selected =
                    currentPage == index;

                return AnimatedContainer(
                  duration:
                  const Duration(
                    milliseconds: 250,
                  ),
                  margin:
                  const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  width: selected ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(
                      100,
                    ),
                    color: selected
                        ? AppColors.main
                        : CoreColors.grey300,
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}