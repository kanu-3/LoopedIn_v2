import 'package:loopedin_v2/core/constants/app_enums.dart';

class SosRequestModel {
  final String id;
  final String requesterId;

  final String title;
  final String? notes;

  final int durationMinutes;

  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime? completedAt;

  final SosStatus status;

  const SosRequestModel({
    required this.id,
    required this.requesterId,
    required this.title,
    this.notes,
    required this.durationMinutes,
    required this.expiresAt,
    required this.createdAt,
    this.completedAt,
    required this.status,
  });

  factory SosRequestModel.fromDb(Map<String, dynamic> json) {
    return SosRequestModel(
      id: json['id'],
      requesterId: json['requester_id'],
      title: json['title'] ?? '',
      notes: json['notes'],
      durationMinutes: json['duration_minutes'] ?? 0,
      expiresAt: DateTime.parse(json['expires_at']),
      createdAt: DateTime.parse(json['created_at']),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      status: SosStatusX.fromDb(json['status']),
    );
  }

  Map<String, dynamic> toInsert(String requesterId) {
    return {
      'requester_id': requesterId,
      'title': title,
      'notes': notes,
      'duration_minutes': durationMinutes,
      'expires_at': expiresAt.toIso8601String(),
      'status': status.dbValue,
    };
  }
}