import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/product_donation.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/widgets/empty_screen.dart';
import 'last_order_charity_details.dart';

class LastOrderCharity extends GetView<BillsController> {
  final bool? isOld;
  const LastOrderCharity({this.isOld = false, super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Any Item Has Accpetd You should Connaction With Company For all Details',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ),
        Obx(() => controller.lastOrderCharity.isEmpty
            ? EmptyOrder()
            : Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children: isOld!
                        ? controller.lastOrderCharity
                            .where((p0) => p0.isAccept! || p0.isCencal!)
                            .map((e) => getWidget(e))
                            .toList()
                        : controller.lastOrderCharity
                            .map((element) => getWidget(element))
                            .toList(),
                  ),
                ),
              )),
      ],
    );
  }

  Widget getWidget(ProductDonation element) => InkWell(
        onTap: () {
          Overlayment.show(OverDialog(
              child: LastOrderCharityDetails(
            productDonation: element,
            charity: element.donation!.charity,
          )));
        },
        child: Card(
          child: ListTile(
            title: Row(
              children: [
                Text('namepro-title'.tr),
                Text(element.companyProduct!.product!.name ?? ''),
              ],
            ),
            trailing: InkWell(
              onTap:
                  element.isCompany! && !element.isAccept! && !element.isCencal!
                      ? () {
                          Overlayment.show(OverDialog(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Do You want To Accept This Donation'),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        await controller.updateDonation(
                                            element.donation!.id!,
                                            true,
                                            false,
                                            element.isCompany!);
                                      },
                                      child: Text('Yes')),
                                  TextButton(
                                      onPressed: () async {
                                        await controller.updateDonation(
                                            element.donation!.id!,
                                            false,
                                            true,
                                            element.isCompany!);
                                      },
                                      child: Text('No')),
                                ],
                              )
                            ],
                          )));
                        }
                      : null,
              child: Chip(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 240, 210, 210),
                  ),
                  backgroundColor: element.isCompany!
                      ? Colors.purple.shade200
                      : Colors.white,
                  label: Text(
                    element.isCompany!
                        ? !element.isAccept! && !element.isCencal!
                            ? 'Accept Donation'
                            : getStatus(element)
                        : !element.isAccept! && !element.isCencal!
                            ? 'WaitingAccepted'
                            : getStatus(element),
                    style: TextStyle(
                      color: !element.isCompany!
                          ? Colors.purple.shade200
                          : Colors.white,
                    ),
                  )),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text('price-title'.tr),
                    Text(
                      element.totalPrice != null
                          ? element.totalPrice.toString()
                          : '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Price Pay :'),
                    Text(
                      element.donation!.pricePay != null
                          ? element.donation!.pricePay.toString()
                          : '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Text(getType(element.donation!.orderTypeId ?? 0))
              ],
            ),
          ),
        ),
      );
  String getType(int id) =>
      controller.orderTypes.where((p0) => p0.id == id).first.name ?? '';
  String getStatus(ProductDonation element) => element.isAccept!
      ? 'Item Accepted'
      : element.isCencal!
          ? 'Item Cancel'
          : '';
}
