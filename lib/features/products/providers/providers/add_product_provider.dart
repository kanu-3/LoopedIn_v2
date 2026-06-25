import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/features/products/providers/notifiers/add_product_notifier.dart';
import 'package:loopedin_v2/features/products/providers/states/add_product_state.dart';

final addProductProvider =
StateNotifierProvider<AddProductNotifier, AddProductState>(
      (ref) => AddProductNotifier(),
);