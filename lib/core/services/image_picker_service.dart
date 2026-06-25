import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  ImagePickerService._();

  static final ImagePicker _picker = ImagePicker();

  static Future<Uint8List?> pickSingleImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return null;

    return await image.readAsBytes();
  }

  static Future<List<Uint8List>> pickMultipleImages({
    int maxImages = 4,
  }) async {
    final images = await _picker.pickMultiImage(
      imageQuality: 80,
    );

    if (images.isEmpty) return [];

    return Future.wait(
      images.take(maxImages).map((e) => e.readAsBytes()),
    );
  }
}