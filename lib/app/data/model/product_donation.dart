import 'package:marketing_surplus/app/data/model/company_product.dart';

import 'donation.dart';

class ProductDonation {
  int? id;
  CompanyProduct? companyProduct;
  Donation? donation;
  int? companyProductId;
  int? donationId;
  int? totalPrice;
  bool? isAccept;
  bool? isCompany;
  bool? isCencal;
  int? amount;
  ProductDonation(
      {this.companyProduct,
      this.companyProductId,
      this.isAccept,
      this.isCencal,
      this.isCompany,
      this.donationId,
      this.donation,
      this.amount,
      this.totalPrice});
  ProductDonation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'] == null ? 0 : int.parse(json['amount'].toString());
    isAccept = json['isAccept'];
    isCompany = json['isCompany'];
    isCencal = json['isCencal'];
    totalPrice = json['totalPrice'] == null
        ? 1
        : int.parse(json['totalPrice'].toString());
    companyProduct = json['companyProduct'] != null
        ? CompanyProduct.fromJson(json['companyProduct'])
        : null;
    donation =
        json['donation'] != null ? Donation.fromJson(json['donation']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['companyProduct'] = companyProduct?.toJson();
    json['companyProductId'] = companyProductId;
    json['donationId'] = donationId;
    json['isCencal'] = isCencal ?? false;
    json['isCompany'] = isCompany ?? false;
    json['isAccept'] = isAccept ?? false;
    json['donation'] = donation?.toJson();
    json['totalPrice'] = totalPrice.toString();
    json['amount'] = amount.toString();
    return json;
  }
}
