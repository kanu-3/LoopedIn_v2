import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/fields/app_text_field.dart';
import 'package:loopedin_v2/features/recommendations/presentation/widgets/recommendation_cart.dart';
import 'package:loopedin_v2/features/recommendations/providers/provider/recommendation_provider.dart';

class RecommendationScreen extends ConsumerStatefulWidget {
  const RecommendationScreen({super.key});

  @override
  ConsumerState<RecommendationScreen> createState() =>
      _RecommendationScreenState();
}

class _RecommendationScreenState
    extends ConsumerState<RecommendationScreen> {
  final titleController = TextEditingController();
  final brandController = TextEditingController();

  String category = "dresses";
  String size = "M";

  final categories = [
    "dresses",
    "tops",
    "shirts",
    "jeans",
    "skirts",
    "kurtis"
  ];

  final sizes = [
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "XXL",
  ];

  @override
  void dispose() {
    titleController.dispose();
    brandController.dispose();
    super.dispose();
  }

  Future<void> recommend() async {
    if (titleController.text.trim().isEmpty) return;

    await ref.read(recommendationProvider.notifier).recommend(
      title: titleController.text.trim(),
      brand: brandController.text.trim(),
      category: category,
      size: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recommendationProvider);

    return Scaffold(
      appBar: AppHeader(
        title: "AI Recommendations",
      ),
      body: RefreshIndicator(
        onRefresh: recommend,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            AppTextField(
              labelText: 'Product Title',
              controller: titleController,
              hintText: "Product Title",
            ),

            const SizedBox(height: 20),

            AppTextField(
              labelText: 'Brand',
              controller: brandController,
              hintText: "Brand",
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(
                labelText: "Category",
              ),
              items: categories
                  .map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: size,
              decoration: const InputDecoration(
                labelText: "Size",
              ),
              items: sizes
                  .map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  size = value!;
                });
              },
            ),

            const SizedBox(height: 24),

            AppButton(
              text: "Get Recommendations",
              onPressed: recommend,
            ),

            const SizedBox(height: 24),

            if (state.isLoading)
              const Center(
                child: Text("Loading..."),
              ),

            // if (state.error != null)
            //   AppErrorWidget(
            //     message: state.error!,
            //     onRetry: recommend,
            //   ),

            if (!state.isLoading &&
                state.error == null &&
                state.recommendations.isNotEmpty)

              GridView.builder(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),
                itemCount:
                state.recommendations.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: .58,
                ),
                itemBuilder: (_, index) {
                  return RecommendationCard(
                    recommendation:
                    state.recommendations[index],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}