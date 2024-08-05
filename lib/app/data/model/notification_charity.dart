import 'product_donation.dart';

class NotificationCharity {
  int? id;
  ProductDonation? productDonation;
  int? productDonationId;
  String? message;
  String? type;
  DateTime? createdAt;
  bool? isRead;
  NotificationCharity({
    this.productDonationId,
    this.message,
    this.type,
    this.isRead,
    this.createdAt,
    this.productDonation,
  });
  NotificationCharity.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    productDonationId = json['productDonationId'];
    message = json['message'];
    type = json['type'];
    isRead = json['isRead'] ?? false;
    createdAt = DateTime.parse(json['createdAt']);
    productDonation = json['productDonation'] != null
        ? ProductDonation.fromJson(json['productDonation'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['productDonation'] = productDonation?.toJson();
    json['productDonationId'] = productDonationId;
    json['createdAt'] = createdAt?.toIso8601String();
    json['message'] = message;
    json['type'] = type;
    json['isRead'] = isRead ?? false;
    return json;
  }
}
