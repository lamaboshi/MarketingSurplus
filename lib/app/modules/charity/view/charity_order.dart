import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/charity/controller/charity_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/widgets/empty_screen.dart';
import '../../../data/model/donation.dart';
import '../../../data/model/product_donation.dart';

class CharityOrder extends GetView<CharityController> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: getMinCard(Icons.add_home_work_rounded, 'last-order-charity'.tr,
          onTab: () {
        Overlayment.show(OverPanel(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => controller.lastOrderCharity.isEmpty
                ? EmptyData()
                : SingleChildScrollView(
                    child: Column(
                      children: controller.lastOrderCharity.map((element) {
                        return ListTile(
                          title: Text(' # ${element.id}'),
                          subtitle: Column(
                            children: [
                              Text(
                                element.charity!.name ?? '',
                                style: TextStyle(
                                    color: Colors.purple.shade200,
                                    fontSize: 19),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(getType(element.orderTypeId ?? 0)),
                                  FloatingActionButton.extended(
                                    backgroundColor: Colors.purple.shade200,
                                    isExtended: true,
                                    onPressed: () {
                                      controller
                                          .getAllDonation(element.charity!.id!);
                                      Overlayment.show(OverDialog(
                                          child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Accept Donation Requst',
                                              style: TextStyle(
                                                  color: Colors.purple.shade200,
                                                  fontSize: 19),
                                            ),
                                          ),
                                          Obx(() => Column(
                                                  children: controller.product
                                                      .where((p0) =>
                                                          p0.companyProduct!
                                                              .company!.id! ==
                                                          controller
                                                              .getCompanyId())
                                                      .map((e) {
                                                print(
                                                    ' isCompany ${e.isCompany!}');
                                                return e.isCompany!
                                                    ? getListTitle(
                                                        e,
                                                        element,
                                                        e.isAccept!
                                                            ? Text(
                                                                'Item Accepetd',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .purple
                                                                        .shade200),
                                                              )
                                                            : !e.isAccept! &&
                                                                    !e.isCencal!
                                                                ? Text(
                                                                    'Waiting to Accpted ',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .purple
                                                                            .shade200))
                                                                : e.isCencal!
                                                                    ? Text(
                                                                        'Not Accpted ',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .purple.shade200))
                                                                    : SizedBox())
                                                    : getListTitle(
                                                        e,
                                                        element,
                                                        widget:
                                                            element.orderTypeId ==
                                                                    2
                                                                ? Wrap(
                                                                    children: [
                                                                      Text(
                                                                          'the Total Price ${e.totalPrice!} value You Will pay :'),
                                                                      Text(getPrice(
                                                                          e,
                                                                          element))
                                                                    ],
                                                                  )
                                                                : SizedBox(),
                                                        Row(
                                                          children: [
                                                            FloatingActionButton
                                                                .extended(
                                                                    backgroundColor: Colors
                                                                        .purple
                                                                        .shade200,
                                                                    onPressed:
                                                                        () async {
                                                                      await controller.updateDonation(
                                                                          element
                                                                              .id!,
                                                                          true,
                                                                          false,
                                                                          e.isCompany!);
                                                                    },
                                                                    label: Text(
                                                                        'Accept')),
                                                            FloatingActionButton
                                                                .extended(
                                                                    backgroundColor: Colors
                                                                        .purple
                                                                        .shade200,
                                                                    onPressed:
                                                                        () async {
                                                                      await controller.updateDonation(
                                                                          element
                                                                              .id!,
                                                                          false,
                                                                          true,
                                                                          e.isCompany!);
                                                                    },
                                                                    label: Text(
                                                                        'Decliend'))
                                                          ],
                                                        ));
                                              }).toList()))
                                        ],
                                      )));
                                    },
                                    label: Text(
                                      'Deltails',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  )),
          ],
        )));
      }),
    );
  }

  String getPrice(ProductDonation e, Donation element) =>
      (e.totalPrice! - element.pricePay!).toString();
  String getType(int id) =>
      controller.orderTypes.where((p0) => p0.id == id).first.name ?? '';

  Widget getListTitle(ProductDonation e, Donation element, Widget trailing,
          {Widget widget = const SizedBox()}) =>
      ListTile(
        title: Text(e.companyProduct!.product!.name ?? ""),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getType(element.orderTypeId ?? 0)),
            Row(
              children: [
                Chip(
                    color: MaterialStatePropertyAll(Colors.orange),
                    label: Text(
                      (e.amount ?? 0).toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                Chip(
                    color: MaterialStatePropertyAll(Colors.green),
                    label: Text(
                      (e.totalPrice ?? 0).toString(),
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                widget,
                trailing,
              ],
            )
          ],
        ),
      );
  Widget getMinCard(IconData icon, String value, {Function? onTab}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onTab!();
        },
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: Colors.purple.shade200,
                  size: 60,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.purple.shade200),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
