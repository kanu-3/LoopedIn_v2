import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/features/sos/data/models/user_preview_model.dart';
import 'sos_request_detail_model.dart';
import 'sos_request_model.dart';

class SosModel {
  final SosRequestModel request;
  final UserPreviewModel requester;
  final List<SosRequestDetailModel> details;
  final List<UserPreviewModel> acceptedUsers;

  const SosModel({
    required this.request,
    required this.requester,
    required this.details,
    required this.acceptedUsers,
  });

  int get acceptedCount => acceptedUsers.length;

  bool get isExpired => request.expiresAt.isBefore(DateTime.now());

  bool get isClosed => request.status != SosStatus.open;
}