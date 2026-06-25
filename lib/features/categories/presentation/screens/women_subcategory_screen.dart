import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/product_constants.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/utils/helpers.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/common/app_image_carousel.dart';
import 'package:loopedin_v2/features/categories/presentation/widgets/subcategory_card.dart';

class WomenSubCategoryScreen extends StatelessWidget {
  const WomenSubCategoryScreen({super.key});

  Future<List<Uint8List>> _loadImages() async {
    return Future.wait([
      loadAssetAsBytes(AssetPaths.sub_cat01),
      loadAssetAsBytes(AssetPaths.sub_cat08),
      loadAssetAsBytes(AssetPaths.sub_cat09),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Women'),
      body: FutureBuilder<List<Uint8List>>(
        future: _loadImages(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final images = snapshot.data!;

          return Column(
            children: [
              AppImageCarousel(
                images: images,
                height: context.scaleH(320),
              ),

              SizedBox(height: context.scaleH(20),),

              Expanded(
                child: GridView.builder(
                  padding: context.bodypad,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: context.spacingS,
                    mainAxisSpacing: context.spacingS,
                    childAspectRatio: .68,
                  ),
                  itemCount: ProductConstants
                      .womenSubCategories.length,
                  itemBuilder: (context, index) {
                    final category =
                    ProductConstants.womenSubCategories[index];

                    return SubCategoryCard(
                      subCategoryName: category,
                      assetImage: ProductConstants
                          .womenSubCategoryImages[index],
                      onTap: () {
                        context.push(
                          RoutePaths.subCategoryProducts,
                          extra: category,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}