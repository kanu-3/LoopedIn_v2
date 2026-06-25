import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';

final authDatasourceProvider =
Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasource(
    SupabaseService.client,
  );
});

final authRepositoryProvider =
Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(authDatasourceProvider),
  );
});

final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>(
      (ref) {
    return AuthNotifier(
      ref.read(authRepositoryProvider),
    );
  },
);