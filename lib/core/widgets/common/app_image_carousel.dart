import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class AppImageCarousel extends StatefulWidget {
  final List<Uint8List> images;
  final double height;
  final BorderRadius? borderRadius;

  const AppImageCarousel({
    super.key,
    required this.images,
    this.height = 440,
    this.borderRadius,
  });

  @override
  State<AppImageCarousel> createState() =>
      _AppImageCarouselState();
}

class _AppImageCarouselState
    extends State<AppImageCarousel> {
  final PageController _pageController =
  PageController();

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (_, index) {
              return Padding(
                padding: context.padAllXS,
                child: ClipRRect(
                  borderRadius:
                  widget.borderRadius ??
                      BorderRadius.circular(context.scale(20)),
                  child: Image.memory(
                    widget.images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),

        if (widget.images.length > 1) ...[
          SizedBox(height: context.scaleH(8)),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
                  (index) => AnimatedContainer(
                duration: const Duration(
                  milliseconds: 200,
                ),
                margin:
                const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                width:
                _currentPage == index
                    ? 20
                    : 8,
                height: context.scaleH(8),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(
                    context.scaleH(100),
                  ),
                  color:
                  _currentPage == index
                      ? AppColors.blacktext
                      : CoreColors.grey300,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}