import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/features/orders/data/datasources/order_remote_datasource.dart';
import 'package:loopedin_v2/features/orders/data/repository/order_repository.dart';
import 'package:loopedin_v2/features/orders/providers/notifiers/order_notifier.dart';
import 'package:loopedin_v2/features/orders/providers/states/order_state.dart';

final orderDatasourceProvider =
Provider<OrderRemoteDatasource>(
      (ref) => OrderRemoteDatasource(
    SupabaseService.client,
  ),
);

final orderRepositoryProvider =
Provider<OrderRepository>(
      (ref) => OrderRepository(
    ref.read(
      orderDatasourceProvider,
    ),
  ),
);

final orderProvider =
StateNotifierProvider<
    OrderNotifier,
    OrderState>(
      (ref) => OrderNotifier(
    ref.read(
      orderRepositoryProvider,
    ),
  ),
);