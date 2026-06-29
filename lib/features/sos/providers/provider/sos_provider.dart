import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/features/sos/data/datasources/sos_remote_datasource.dart';
import 'package:loopedin_v2/features/sos/data/repository/sos_repository.dart';
import 'package:loopedin_v2/features/sos/providers/notifier/sos_notifier.dart';
import 'package:loopedin_v2/features/sos/providers/state/sos_state.dart';

final sosDatasourceProvider = Provider(
      (ref) => SosRemoteDatasource(SupabaseService.client),
);

final sosRepositoryProvider = Provider(
      (ref) => SosRepository(
    ref.read(sosDatasourceProvider),
  ),
);

final sosProvider =
StateNotifierProvider<SosNotifier, SosState>(
      (ref) => SosNotifier(
    ref.read(sosRepositoryProvider),
  ),
);