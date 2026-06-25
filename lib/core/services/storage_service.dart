import 'dart:typed_data';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/features/products/data/models/uploaded_image_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  StorageService._();

  static const String productBucket = 'product-images';

  static Future<UploadedImageModel> uploadProductImage({
    required Uint8List image,
    required String userId,
  }) async {
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.jpg';

    final path = '$userId/products/$fileName';

    await SupabaseService.client.storage
        .from(productBucket)
        .uploadBinary(
      path,
      image,
      fileOptions: const FileOptions(
        contentType: 'image/jpeg',
      ),
    );

    final url = SupabaseService.client.storage
        .from(productBucket)
        .getPublicUrl(path);

    return UploadedImageModel(
      url: url,
      storagePath: path,
    );
  }

  static Future<List<UploadedImageModel>>
  uploadProductImages({
    required List<Uint8List> images,
    required String userId,
  }) async {
    final uploaded = <UploadedImageModel>[];

    for (final image in images) {
      uploaded.add(
        await uploadProductImage(
          image: image,
          userId: userId,
        ),
      );
    }

    return uploaded;
  }

  static Future<void> deleteImage(String path) async {
    await SupabaseService.client.storage
        .from(productBucket)
        .remove([path]);
  }

  static Future<void> deleteFiles(List<String> paths) async {
    if (paths.isEmpty) return;

    await SupabaseService.client.storage
        .from('product-images')
        .remove(paths);
  }
}