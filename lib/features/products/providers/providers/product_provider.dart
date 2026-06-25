import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/features/products/data/datasources/product_remote_datasource.dart';
import 'package:loopedin_v2/features/products/data/repositories/product_repository.dart';
import 'package:loopedin_v2/features/products/providers/notifiers/product_notifier.dart';
import 'package:loopedin_v2/features/products/providers/states/product_state.dart';

final productDatasourceProvider = Provider<ProductRemoteDatasource>(
      (ref) => ProductRemoteDatasource(SupabaseService.client),
);

final productRepositoryProvider = Provider<ProductRepository>(
      (ref) => ProductRepository(
    ref.read(productDatasourceProvider),
  ),
);

final productProvider =
StateNotifierProvider<ProductNotifier, ProductState>(
      (ref) => ProductNotifier(ref.read(productRepositoryProvider)),
);