import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product.dart';
import 'package:marketing_surplus/shared/widgets/auth_bottom_sheet.dart';

class SingleItem extends GetView {
  final CompanyProduct product;
  final String? type;
  final bool? enable;
  final VoidCallback onTap;
  const SingleItem(this.product, this.onTap, this.enable,
      {this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
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
                      child: Image.asset(
                        'assets/images/post_2.jpg',
                        width: 120,
                        height: 120,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.product!.name == null
                                  ? ''
                                  : product.product!.name!,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              product.product!.description == null
                                  ? 'No Description'
                                  : product.product!.description!,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
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
                            const SizedBox(
                              width: 10,
                            ),
                            Chip(
                                side: BorderSide(color: Colors.green.shade400),
                                backgroundColor: Colors.green.shade400,
                                labelPadding: const EdgeInsets.all(2),
                                label: Text(
                                  product.amount != null
                                      ? product.amount.toString()
                                      : '0',
                                  style: const TextStyle(color: Colors.white),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Chip(
                                side: BorderSide(color: Colors.red.shade400),
                                backgroundColor: Colors.red.shade400,
                                labelPadding: const EdgeInsets.all(2),
                                label: Text(
                                  '${getPercentage(product.product!.oldPrice!, product.product!.price!)}%',
                                  style: const TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product.product!.price == null
                              ? ''
                              : ' ${product.product!.price!}\$',
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
                    InkWell(
                      onTap: () async {
                        if (enable!) {
                          await AuthBottomSheet().modalBottomSheet(context);
                        } else {
                          onTap();
                        }
                      },
                      child: Chip(
                          backgroundColor: Colors.purple.shade200,
                          label: const Text(
                            'Buy',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
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

  double getPercentage(double p1, double p2) => ((p1 / p2) - p1) * 100;
}
