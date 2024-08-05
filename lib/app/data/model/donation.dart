import 'charity.dart';
import 'order_type.dart';
import 'product_donation.dart';

class Donation {
  int? id;
  Charity? charity;
  OrderType? orderType;
  int? charityId;
  int? orderTypeId;
  double? pricePay;
  double? percentage;
  DateTime? createdAt;
  List<ProductDonation>? productDonations;
  Donation({
    this.charity,
    this.orderType,
    this.charityId,
    this.orderTypeId,
    this.createdAt,
    this.pricePay,
  });
  Donation.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    pricePay = json['pricePay'] == null
        ? 1
        : double.parse(json['pricePay'].toString());
    percentage = json['percentage'] == null
        ? 0
        : double.parse(json['percentage'].toString());
    orderTypeId = json['orderTypeId'];
    createdAt = DateTime.parse(json['createdAt']);
    charity =
        json['charity'] != null ? Charity.fromJson(json['charity']) : null;
    orderType = json['orderType'] != null
        ? OrderType.fromJson(json['orderType'])
        : null;
    // productDonations =
    //     json['productDonations'] == null || json['productDonations'] == [null]
    //         ? []
    //         : List<ProductDonation>.from(json['productDonations']
    //             .map<ProductDonation>((i) => ProductDonation.fromJson(i)));
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['orderType'] = orderType == null ? null : orderType?.toJson();
    json['orderTypeId'] = orderTypeId;
    json['createdAt'] = createdAt?.toIso8601String();
    json['charityId'] = charityId;
    json['charity'] = charity?.toJson();
    json['pricePay'] = pricePay == null ? 0 : pricePay.toString();
    json['percentage'] = percentage == null ? 0 : percentage.toString();
    return json;
  }
}
