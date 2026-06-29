import 'package:loopedin_v2/features/sos/data/datasources/sos_remote_datasource.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_model.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_request_detail_model.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_request_model.dart';

class SosRepository {
  final SosRemoteDatasource remote;

  SosRepository(this.remote);

  Future<String> createSos(SosRequestModel request) =>
      remote.createSos(request);

  Future<void> addRequestDetails({
    required String sosId,
    required List<SosRequestDetailModel> details,
  }) =>
      remote.addRequestDetails(sosId: sosId, details: details);

  Future<List<SosModel>> fetchOpenSos() => remote.fetchOpenSos();

  Future<List<SosModel>> fetchMySos() => remote.fetchMySos();

  Future<void> acceptSos(String sosId) => remote.acceptSos(sosId);

  Future<void> declineSos(String sosId) => remote.declineSos(sosId);

  Future<void> closeSos(String sosId) => remote.closeSos(sosId);
}