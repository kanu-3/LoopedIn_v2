enum OfferStatus {
  pending,
  accepted,
  rejected,
}

extension OfferStatusX on OfferStatus {
  String get dbValue => name;

  static OfferStatus fromDb(dynamic v) {
    switch (v?.toString()) {
      case 'accepted':
        return OfferStatus.accepted;
      case 'rejected':
        return OfferStatus.rejected;
      case 'pending':
      default:
        return OfferStatus.pending;
    }
  }
}
enum order_status	{
  pending,
  shipped,
  completed,
  cancelled
}
enum product_availability {
  sell,
  rent,
  both
}
enum product_status {
  active,
  sold,
  rented,
  inactive,
}
enum PurchaseType {
  buy,
  rent,
}
enum ProductActionBarMode {
  owner,
  visitor,
}
enum SosStatus {
  open,
  closed,
  expired,
}
extension SosStatusX on SosStatus {
  String get dbValue => name;

  static SosStatus fromDb(dynamic value) {
    switch (value?.toString()) {
      case 'closed':
        return SosStatus.closed;
      case 'expired':
        return SosStatus.expired;
      case 'open':
      default:
        return SosStatus.open;
    }
  }
}
enum SosResponseStatus {
  accepted,
  declined,
}
extension SosResponseStatusX on SosResponseStatus {
  String get dbValue => name;

  static SosResponseStatus fromDb(dynamic value) {
    switch (value?.toString()) {
      case 'declined':
        return SosResponseStatus.declined;
      case 'accepted':
      default:
        return SosResponseStatus.accepted;
    }
  }
}