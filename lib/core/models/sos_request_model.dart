class SOSRequestModel {
  final String id;
  final String requesterId;
  final String title;
  final String categoryId;
  final String size;
  final String? brand;
  final String? style;
  final String? pattern;
  final String? color;
  final String? description;
  final String? image;
  final bool expressDelivery;
  final bool alteration;
  final bool dryClean;
  final String status;
  final DateTime expiresAt;
  final DateTime createdAt;

  const SOSRequestModel({
    required this.id,
    required this.requesterId,
    required this.title,
    required this.categoryId,
    required this.size,
    required this.brand,
    required this.style,
    required this.pattern,
    required this.color,
    required this.description,
    required this.image,
    required this.expressDelivery,
    required this.alteration,
    required this.dryClean,
    required this.status,
    required this.expiresAt,
    required this.createdAt,
});
}