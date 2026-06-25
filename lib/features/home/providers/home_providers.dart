import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/features/home/data/datasources/home_remote_datasource.dart';
import 'package:loopedin_v2/features/home/data/repository/home_repository.dart';
import 'package:loopedin_v2/features/home/providers/home_notifier.dart';
import 'package:loopedin_v2/features/home/providers/home_state.dart';

final homeDatasourceProvider =
Provider<HomeRemoteDatasource>(
      (ref) {

    return HomeRemoteDatasource(
      SupabaseService.client,
    );
  },
);

final homeRepositoryProvider =
Provider<HomeRepository>(
      (ref) {

    return HomeRepository(
      ref.read(
        homeDatasourceProvider,
      ),
    );
  },
);

final homeProvider =
StateNotifierProvider<
    HomeNotifier,
    HomeState>(
      (ref) {

    return HomeNotifier(
      ref.read(
        homeRepositoryProvider,
      ),
    );
  },
);