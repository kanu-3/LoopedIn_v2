import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_request_detail_model.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_request_model.dart';
import 'package:loopedin_v2/features/sos/data/repository/sos_repository.dart';
import 'package:loopedin_v2/features/sos/providers/state/sos_state.dart';

class SosNotifier extends StateNotifier<SosState> {
  final SosRepository repository;

  SosNotifier(this.repository) : super(SosState.initial());

  String get _uid =>
      repository.remote.client.auth.currentUser!.id;

  Future<void> fetchFeed() async {
    print("fetchFeed() called");

    state = state.copyWith(
      isLoading: true,
    );

    try {
      final feed =
      await repository.fetchOpenSos();

      print("Fetched ${feed.length} SOS");

      state = state.copyWith(
        feed: feed,
      );
    } catch (e, st) {
      print("fetchFeed Error");
      print(e);
      print(st);
    } finally {
      state = state.copyWith(
        isLoading: false,
      );
    }
  }

  Future<void> fetchMySos() async {
    final my = await repository.fetchMySos();
    state = state.copyWith(mySos: my);
  }

  Future<void> createSos({
    required String title,
    String? notes,
    required int durationMinutes,
    required DateTime expiresAt,
    required List<SosRequestDetailModel> details,
  }) async {
    state = state.copyWith(isCreating: true);

    try {
      final request = SosRequestModel(
        id: '',
        requesterId: _uid,
        title: title,
        notes: notes,
        durationMinutes: durationMinutes,
        expiresAt: expiresAt,
        createdAt: DateTime.now(),
        completedAt: null,
        status: SosStatus.open,
      );

      final id = await repository.createSos(request);

      await repository.addRequestDetails(
        sosId: id,
        details: details,
      );

      await fetchFeed();
      await fetchMySos();
    } finally {
      state = state.copyWith(isCreating: false);
    }
  }

  Future<void> acceptSos(String sosId) async {
    await repository.acceptSos(sosId);

    final updated = Map<String, SosResponseStatus>.from(
      state.myResponses,
    );

    updated[sosId] = SosResponseStatus.accepted;

    state = state.copyWith(myResponses: updated);

    await fetchFeed();
    await fetchMySos();
  }

  Future<void> declineSos(String sosId) async {
    await repository.declineSos(sosId);

    final updated = Map<String, SosResponseStatus>.from(
      state.myResponses,
    );

    updated[sosId] = SosResponseStatus.declined;

    state = state.copyWith(myResponses: updated);

    await fetchFeed();
    await fetchMySos();
  }

  Future<void> closeSos(String sosId) async {
    await repository.closeSos(sosId);
    await fetchFeed();
    await fetchMySos();
  }
}