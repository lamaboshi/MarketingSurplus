import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/product_donation.dart';

import 'package:marketing_surplus/app/modules/profile/controller/profile_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../data/model/charity.dart';

class LastOrderCharityDetails extends GetView<ProfileController> {
  final ProductDonation? productDonation;
  final Charity? charity;
  LastOrderCharityDetails({this.productDonation, this.charity});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'order-details'.tr,
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade200),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Overlayment.dismissLast();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.purple.shade200,
                    ))
              ],
            ),
            if (productDonation!.donation!.orderTypeId != null)
              getRow('Order Type',
                  getType(productDonation!.donation!.orderTypeId!)),
            if (productDonation!.donation!.createdAt != null)
              getRow('Created At',
                  productDonation!.donation!.createdAt.toString()),
            if (productDonation!.companyProduct!.product != null)
              getRow('namepro-title',
                  productDonation!.companyProduct!.product!.name ?? ''),
            if (productDonation!.companyProduct!.product != null)
              getRow('despro-title',
                  productDonation!.companyProduct!.product!.descripation ?? ''),
            if (productDonation!.companyProduct!.product != null)
              getRow(
                  'expda-title',
                  productDonation!.companyProduct!.product!.expiration
                      .toString()),
            if (productDonation!.companyProduct!.product != null)
              getRow(
                  'creatda-title',
                  productDonation!.companyProduct!.product!.dateTime
                      .toString()),
            if (productDonation!.companyProduct!.product != null)
              getRow(
                  'new-price',
                  productDonation!.companyProduct!.product!.newPrice
                      .toString()),
            if (productDonation!.companyProduct!.product != null)
              getRow(
                  'oldpri-title',
                  productDonation!.companyProduct!.product!.oldPrice
                      .toString()),
            getRow('amoutth-title',
                productDonation!.companyProduct!.amount.toString()),
            if (productDonation!.companyProduct!.company != null)
              getRow('cmp-name',
                  productDonation!.companyProduct!.company!.name ?? ''),
            if (productDonation!.companyProduct!.company != null)
              getRow('cmp-email',
                  productDonation!.companyProduct!.company!.email ?? ''),
            if (productDonation!.companyProduct!.company != null)
              getRow('cmp-phone',
                  productDonation!.companyProduct!.company!.phone ?? ''),
            if (charity != null)
              getRow(
                  'ch-phone', productDonation!.donation!.charity!.name ?? ''),
            if (charity != null)
              getRow(
                  'ch-phone', productDonation!.donation!.charity!.phone ?? ''),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('all-status'.tr),
                )),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(children: [
                        if (productDonation!.isCompany!)
                          Chip(
                              label: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              'from Company ${productDonation!.isCompany!}',
                              style: TextStyle(color: Colors.purple.shade200),
                            ),
                          )),
                        if (productDonation!.isAccept!)
                          Chip(
                              label: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              'isAccept ${productDonation!.isAccept!}',
                              style: TextStyle(color: Colors.purple.shade200),
                            ),
                          )),
                        if (productDonation!.isCencal!)
                          Chip(
                              label: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              'isCencal ${productDonation!.isCencal!}',
                              style: TextStyle(color: Colors.purple.shade200),
                            ),
                          )),
                        if (!productDonation!.isCencal! &&
                            !productDonation!.isAccept!)
                          Chip(
                              label: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              'isWaiting ${(!productDonation!.isCencal! && !productDonation!.isAccept!)}',
                              style: TextStyle(color: Colors.purple.shade200),
                            ),
                          ))
                      ]),
                    ))
              ],
            ),
            if (productDonation!.commintCencal != null &&
                productDonation!.commintCencal!.trim().isNotEmpty)
              getRow('Cancel Reson', productDonation!.commintCencal!),
            getRow('amount-title', productDonation!.amount.toString()),
            getRow('price-title', productDonation!.totalPrice.toString()),
            if (getPriceDontation() &&
                productDonation!.donation!.pricePay != null)
              getRow('dontain PayPrice :',
                  productDonation!.donation!.pricePay.toString()),
            if (getPriceDontation() &&
                productDonation!.donation!.percentage != null)
              getRow('Percentage :',
                  ' ${productDonation!.donation!.percentage.toString()}%')
          ],
        ),
      ),
    );
  }

  String getType(int id) =>
      controller.orderTypes.where((p0) => p0.id == id).first.name ?? '';
  // 1 for normal
  //2 for donation
  //3 for ACh
  bool getPriceDontation() => productDonation!.donation!.orderTypeId == 3;
  Widget getRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title.tr),
        )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: Get.width - 200,
              child: Row(
                children: [
                  Flexible(child: Text(value.tr)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
