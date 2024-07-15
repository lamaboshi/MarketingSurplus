import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product.dart';
import 'package:marketing_surplus/shared/widgets/auth_bottom_sheet.dart';
import 'package:overlayment/overlayment.dart';

import '../../app/modules/product/view/produtc_page.dart';
import '../service/util.dart';

class SingleItem extends GetView {
  final CompanyProduct product;
  final String? type;
  final bool? enable;
  final VoidCallback onTap;
  final VoidCallback editTap;
  final VoidCallback deleteTap;
  final bool? isCompany;
  const SingleItem(this.product, this.isCompany, this.onTap, this.editTap,
      this.deleteTap, this.enable,
      {this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Overlayment.show(OverDialog(
                child: ProductView(
              product: product,
              onTap: onTap,
            )));
          },
          child: Stack(
            children: [
              Card(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: Colors.purple.shade200,
                            child: Column(
                              children: [
                                type == null
                                    ? const SizedBox.shrink()
                                    : Chip(
                                        side: BorderSide(
                                            color: Colors.purple.shade200),
                                        backgroundColor: Colors.white,
                                        label: Text(
                                          type!,
                                          style: TextStyle(
                                              color: Colors.purple.shade200),
                                        )),
                                SizedBox(
                                  height: Get.height / 6,
                                  width: Get.width / 4,
                                  child: Utility.getImage(
                                    base64StringPh: product.product!.image,
                                    link: product.product!.onlineImage,
                                  ),
                                )
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width / 3.6,
                                    height: 25,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            product.product!.name == null
                                                ? ''
                                                : product.product!.name!,
                                            style:
                                                const TextStyle(fontSize: 18),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width / 3.6,
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            product.product!.descripation ==
                                                    null
                                                ? 'no-description'
                                                : product
                                                    .product!.descripation!,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  Chip(
                                      side: BorderSide(
                                          color: Colors.green.shade400),
                                      backgroundColor: Colors.green.shade400,
                                      labelPadding: const EdgeInsets.all(2),
                                      label: Text(
                                        product.amount != null
                                            ? product.amount.toString()
                                            : '0',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                  Chip(
                                      side: BorderSide(
                                          color: Colors.red.shade400),
                                      backgroundColor: Colors.red.shade400,
                                      labelPadding: const EdgeInsets.all(2),
                                      label: Text(
                                        '${getPercentage(product.product!.oldPrice!, product.product!.newPrice!).toStringAsFixed(2)}%',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                product.product!.newPrice == null
                                    ? ''
                                    : ' ${product.product!.newPrice!}\$',
                                style: TextStyle(color: Colors.purple.shade200),
                              ),
                              Text(
                                product.product!.oldPrice == null
                                    ? ''
                                    : ' ${product.product!.oldPrice!}\$',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          isCompany!
                              ? Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          editTap();
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          deleteTap();
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  ],
                                )
                              : InkWell(
                                  onTap: () async {
                                    if (enable!) {
                                      await AuthBottomSheet()
                                          .modalBottomSheet(context);
                                    } else {
                                      onTap();
                                    }
                                  },
                                  child: Chip(
                                      backgroundColor: Colors.purple.shade200,
                                      label: Text(
                                        'buy'.tr,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              product.product!.isExpiration!
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        color: Colors.orange,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Expired'.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        )

        // ListTile(
        //   leading: Card(
        //       shape:
        //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        //       color: Colors.purple.shade200,
        //       child: Image.asset(
        //         'assets/images/logo.png',
        //         width: 150,
        //         height: 150,
        //       )),
        //   title: Text(product.name == null ? '' : product.name!),
        //   subtitle: Text(product.description == null ? '' : product.description!),
        //   trailing: Text(product.price == null ? '' : ' ${product.price!}\$'),
        // ),
        );
  }

  double getPercentage(double p1, double p2) => 100 - ((p2 * 100) / p1);
}
