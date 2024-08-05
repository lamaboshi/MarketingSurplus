import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/charity/controller/charity_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/widgets/empty_screen.dart';
import '../../../../shared/widgets/textfield_widget.dart';
import '../../../data/model/donation.dart';
import '../../../data/model/product_donation.dart';

class CharityOrder extends GetView<CharityController> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: getMinCard(Icons.add_home_work_rounded, 'last-order-charity'.tr,
          onTab: () {
        controller.getLastOrderCharity();
        Overlayment.show(OverPanel(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: IconButton(
                      onPressed: () {
                        print('object');
                        Overlayment.dismissLast();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.purple.shade200,
                      )),
                ),
              ),
              Obx(() => controller.lastOrderCharityJustCharity.isEmpty
                  ? EmptyData()
                  : SingleChildScrollView(
                      child: Column(
                        children: controller.lastOrderCharityJustCharity
                            .map((element) {
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
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.purple.shade200)),
                                      onPressed: () {
                                        controller.getAllDonation(
                                            element.charity!.id!);
                                        Overlayment.show(OverDialog(
                                            child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Accept Donation Requst',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .purple.shade200,
                                                      fontSize: 19),
                                                ),
                                              ),
                                              Obx(() => Column(
                                                      children: controller
                                                          .product
                                                          .map((e) {
                                                    print(
                                                        ' isCompany ${e.isCompany!}');

                                                    return e.isCompany!
                                                        ? getListTitle(
                                                            e,
                                                            element,
                                                            getStatus(
                                                                e,
                                                                Text(
                                                                    'Waiting to Accpted ',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .purple
                                                                            .shade200,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold))))
                                                        : getListTitle(
                                                            e,
                                                            element,
                                                            widget: e.donation!
                                                                        .orderTypeId ==
                                                                    3
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
                                                            getStatus(
                                                                e,
                                                                Row(
                                                                  children: [
                                                                    ElevatedButton(
                                                                        style: ButtonStyle(
                                                                            backgroundColor: MaterialStatePropertyAll(Colors
                                                                                .purple.shade200)),
                                                                        onPressed:
                                                                            () async {
                                                                          await controller.updateDonation(
                                                                              e.donation!.id!,
                                                                              true,
                                                                              false,
                                                                              e.isCompany!,
                                                                              getType(element.orderTypeId!),
                                                                              element.charity!,
                                                                              e.id!);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Accept',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        )),
                                                                    ElevatedButton(
                                                                        style: ButtonStyle(
                                                                            backgroundColor: MaterialStatePropertyAll(Colors
                                                                                .purple.shade200)),
                                                                        onPressed:
                                                                            () async {
                                                                          Overlayment.show(OverDialog(
                                                                              child: Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  'Why You Didn\'t Want to Accept',
                                                                                  style: TextStyle(color: Colors.purple.shade200),
                                                                                ),
                                                                              ),
                                                                              TextFieldWidget(
                                                                                icon: Icons.adjust_sharp,
                                                                                onChanged: (value) {
                                                                                  controller.notAccept.value = value;
                                                                                },
                                                                                textInputType: TextInputType.emailAddress,
                                                                                label: 'Not Accept reason'.tr,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 8,
                                                                              ),
                                                                              FloatingActionButton.extended(
                                                                                  backgroundColor: Colors.purple.shade200,
                                                                                  onPressed: () async {
                                                                                    await controller.updateDonation(e.donation!.id!, false, true, e.isCompany!, getType(element.orderTypeId!), element.charity!, e.id!);
                                                                                  },
                                                                                  label: Text(
                                                                                    'Done',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ))
                                                                            ],
                                                                          )));
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Decliend',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        )),
                                                                  ],
                                                                )));
                                                  }).toList()))
                                            ],
                                          ),
                                        )));
                                      },
                                      child: Text(
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
          ),
        )));
      }),
    );
  }

  Widget getStatus(ProductDonation e, Widget subWait) => e.isAccept!
      ? Text(
          'Item Accepetd',
          style: TextStyle(
              color: Colors.purple.shade200, fontWeight: FontWeight.bold),
        )
      : !e.isAccept! && !e.isCencal!
          ? subWait
          : e.isCencal!
              ? Column(
                  children: [
                    Text('Not Accpted ',
                        style: TextStyle(
                            color: Colors.purple.shade200,
                            fontWeight: FontWeight.bold)),
                    Text(e.commintCencal ?? '')
                  ],
                )
              : SizedBox();
  String getPrice(ProductDonation e, Donation element) =>
      (e.totalPrice! - e.donation!.pricePay!).toString();
  String getType(int id) =>
      controller.orderTypes.where((p0) => p0.id == id).first.name ?? '';

  Widget getListTitle(ProductDonation e, Donation element, Widget trailing,
          {Widget widget = const SizedBox()}) =>
      ListTile(
        title: Text(e.companyProduct!.product!.name ?? ""),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getType(e.donation!.orderTypeId ?? 0)),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
