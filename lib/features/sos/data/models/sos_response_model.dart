import 'package:loopedin_v2/core/constants/app_enums.dart';

class SosResponseModel {
  final String id;
  final String sosId;
  final String responderId;
  final SosResponseStatus status;
  final DateTime respondedAt;

  const SosResponseModel({
    required this.id,
    required this.sosId,
    required this.responderId,
    required this.status,
    required this.respondedAt,
  });

  factory SosResponseModel.fromDb(Map<String, dynamic> json) {
    return SosResponseModel(
      id: json['id'],
      sosId: json['sos_id'],
      responderId: json['responder_id'],
      status: SosResponseStatusX.fromDb(json['status']),
      respondedAt: DateTime.parse(json['responded_at']),
    );
  }
}