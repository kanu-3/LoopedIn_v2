import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_model.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_request_detail_model.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_request_model.dart';
import 'package:loopedin_v2/features/sos/data/models/user_preview_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SosRemoteDatasource {
  final SupabaseClient client;

  SosRemoteDatasource(this.client);

  String get _uid => client.auth.currentUser!.id;

  Future<String> createSos(SosRequestModel request) async {
    final inserted = await client
        .from('sos_requests')
        .insert(request.toInsert(_uid))
        .select()
        .single();

    return inserted['id'];
  }

  Future<void> addRequestDetails({
    required String sosId,
    required List<SosRequestDetailModel> details,
  }) async {
    if (details.isEmpty) return;

    await client.from('sos_request_details').insert(
      details.map((e) => e.toInsert(sosId)).toList(),
    );
  }

  Future<List<SosModel>> fetchOpenSos() async {
    final response = await client
        .from('sos_requests')
        .select()
        .eq('status', 'open')
        .neq('requester_id', _uid);

    print("RAW RESPONSE:");
    print(response);
    print("COUNT = ${response.length}");

    return _buildModels(response);
  }

  Future<List<SosModel>> fetchMySos() async {
    final response = await client
        .from('sos_requests')
        .select()
        .eq('requester_id', _uid)
        .order('created_at', ascending: false);

    return _buildModels(response);
  }

  Future<void> acceptSos(String sosId) async {
    await _respond(sosId, SosResponseStatus.accepted);
  }

  Future<void> declineSos(String sosId) async {
    await _respond(sosId, SosResponseStatus.declined);
  }

  Future<void> _respond(String sosId, SosResponseStatus status) async {
    await client.from('sos_responses').insert({
      'sos_id': sosId,
      'responder_id': _uid,
      'status': status.dbValue,
    });
  }

  // CLOSE SOS (OWNER ONLY)
  Future<void> closeSos(String sosId) async {
    await client
        .from('sos_requests')
        .update({
      'status': 'closed',
      'completed_at': DateTime.now().toIso8601String(),
    })
        .eq('id', sosId)
        .eq('requester_id', _uid);
  }

  Future<List<SosModel>> _buildModels(
      List data) async {

    print("_buildModels");
    print("Rows = ${data.length}");

    final List<SosModel> list = [];

    for (final raw in data) {

      print(raw);

      final request =
      SosRequestModel.fromDb(raw);

      final requester =
      await _fetchProfile(
          request.requesterId);

      final details =
      await _fetchDetails(request.id);

      final accepted =
      await _fetchAcceptedUsers(
          request.id);

      list.add(
        SosModel(
          request: request,
          requester: requester,
          details: details,
          acceptedUsers: accepted,
        ),
      );
    }

    print("Returning ${list.length}");

    return list;
  }

  Future<List<SosRequestDetailModel>> _fetchDetails(String id) async {
    final res = await client
        .from('sos_request_details')
        .select()
        .eq('sos_id', id);

    return (res as List)
        .map((e) => SosRequestDetailModel.fromDb(e))
        .toList();
  }

  Future<UserPreviewModel> _fetchProfile(String userId) async {
    final user = await client
        .from('users')
        .select('username')
        .eq('user_id', userId)
        .single();

    final profile = await client
        .from('user_profile')
        .select('name, profile_pic')
        .eq('user_id', userId)
        .maybeSingle();

    return UserPreviewModel(
      userId: userId,
      username: user['username'],
      name: profile?['name'] ?? '',
      profilePic: profile?['profile_pic'],
    );
  }

  Future<List<UserPreviewModel>> _fetchAcceptedUsers(String sosId) async {
    final res = await client
        .from('sos_responses')
        .select()
        .eq('sos_id', sosId)
        .eq('status', 'accepted');

    final List<UserPreviewModel> users = [];

    for (final r in res) {
      users.add(await _fetchProfile(r['responder_id']));
    }

    return users;
  }
}