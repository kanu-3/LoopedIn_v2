class SosRequestDetailModel {
  final String id;
  final String sosId;

  final String title;
  final String? size;
  final String? brand;
  final String? style;
  final String? pattern;
  final String? color;
  final String? description;

  final String? referenceImage;
  final DateTime createdAt;

  const SosRequestDetailModel({
    required this.id,
    required this.sosId,
    required this.title,
    this.size,
    this.brand,
    this.style,
    this.pattern,
    this.color,
    this.description,
    this.referenceImage,
    required this.createdAt,
  });

  factory SosRequestDetailModel.fromDb(Map<String, dynamic> json) {
    return SosRequestDetailModel(
      id: json['id'],
      sosId: json['sos_id'],
      title: json['title'] ?? '',
      size: json['size'],
      brand: json['brand'],
      style: json['style'],
      pattern: json['pattern'],
      color: json['color'],
      description: json['description'],
      referenceImage: json['reference_image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toInsert(String sosId) {
    return {
      'sos_id': sosId,
      'title': title,
      'size': size,
      'brand': brand,
      'style': style,
      'pattern': pattern,
      'color': color,
      'description': description,
      'reference_image': referenceImage,
    };
  }
}