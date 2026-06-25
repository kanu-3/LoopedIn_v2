import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/app_constants.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/services/image_picker_service.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:path/path.dart';

class ProductImagePicker extends StatelessWidget {
  const ProductImagePicker({
    super.key,
    required this.images,
    required this.onChanged,
  });

  final List<Uint8List> images;
  final ValueChanged<List<Uint8List>> onChanged;

  Future<void> _pickImages(
      BuildContext context,
      ) async {
    const max = AppConstants.maxProductImages;

    if (images.length >= max) {
      AppSnackBar.show(
        context,
        message: "Maximum $max images allowed",
        isError: true,
      );
      return;
    }

    final remaining = max - images.length;

    final picked =
    await ImagePickerService.pickMultipleImages(
      maxImages: remaining,
    );

    if (picked.isEmpty) return;

    if (picked.length > remaining) {
      AppSnackBar.show(
        context,
        message:
        "Only $remaining more images can be added",
      );
    }

    final updated = [
      ...images,
      ...picked.take(remaining),
    ];

    onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length + 1,
            separatorBuilder: (_, __) =>
            const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index == images.length) {
                return InkWell(
                  onTap: () =>
                      _pickImages(context),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.main,
                      ),
                      borderRadius:
                      BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: Icon(
                      AssetPaths.add_photo,
                    ),
                  ),
                );
              }

              return Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(
                      12,
                    ),
                    child: Image.memory(
                      images[index],
                      width: 100,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    right: 4,
                    top: 4,
                    child: GestureDetector(
                      onTap: () {
                        final updated =
                        List<Uint8List>.from(
                          images,
                        );

                        updated.removeAt(
                          index,
                        );

                        onChanged(updated);
                      },
                      child:
                      const CircleAvatar(
                        radius: 12,
                        child: Icon(
                          AssetPaths.cross,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "${images.length}/${AppConstants.maxProductImages} images selected",
          style: Theme.of(context)
              .textTheme
              .bodySmall,
        ),
      ],
    );
  }
}