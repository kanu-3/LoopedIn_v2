import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/categories/presentation/widgets/category_card.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppHeader(
          title: 'Categories',
          showCloseButton: false,
          showBackButton: false,
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.bodypad,
          child: Column(
            children: [
              CategoryCard(category: "Trending", assetImage: AssetPaths.cat01, onTap: (){}, color: CoreColors.cat01),
              context.gapL,
              CategoryCard(category: "Rent", assetImage: AssetPaths.cat02, onTap: (){}, color: CoreColors.cat02),
              context.gapL,
              CategoryCard(category: "Buy", assetImage: AssetPaths.cat03, onTap: (){}, color: CoreColors.cat03),
              context.gapL,
              CategoryCard(category: "Women", assetImage: AssetPaths.cat04, onTap: () {
                context.push(
                  RoutePaths.womenSubCategories,
                );
              }, color: CoreColors.cat04),
              context.gapL,
              CategoryCard(category: "Kids", assetImage: AssetPaths.cat05, onTap: (){}, color: CoreColors.cat05),
              context.gapL,
              CategoryCard(category: "Men", assetImage: AssetPaths.cat06,fit: BoxFit.cover, onTap: (){}),
              context.gapL,
              CategoryCard(category: "Donate", assetImage: AssetPaths.cat07,fit: BoxFit.cover, onTap: (){}),

            ],
          ),
        ),
      ),
    );
  }
}
