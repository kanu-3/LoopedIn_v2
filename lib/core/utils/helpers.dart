import 'dart:typed_data';
import 'package:flutter/services.dart';

Future<Uint8List> loadAssetAsBytes(String path) async {
  final byteData = await rootBundle.load(path);
  return byteData.buffer.asUint8List();
}