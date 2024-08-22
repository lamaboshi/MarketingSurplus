import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/shared/widgets/empty_screen.dart';
import 'package:overlayment/overlayment.dart';

import '../controller/bills_controller.dart';

class DetailsProduct extends GetView<BillsController> {
  final int? typeId;
  final int? id;
  const DetailsProduct({this.typeId, this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'choos-detail'.tr,
            style: TextStyle(color: Colors.purple.shade200, fontSize: 18),
          ),
          typeId == 4
              ? Obx(() => Column(
                    children: [
                      controller.food1.value.isEmpty
                          ? SizedBox.shrink()
                          : Text('Ketchup :${controller.food1.value} '),
                      controller.food2.value.isEmpty
                          ? SizedBox.shrink()
                          : Text('Pickles :${controller.food2.value}, '),
                      controller.food3.value.isEmpty
                          ? SizedBox.shrink()
                          : Text('Salt :${controller.food3.value}'),
                      controller.food4.value.isEmpty
                          ? SizedBox.shrink()
                          : Text('French fries :${controller.food4.value}'),
                    ],
                  ))
              : typeId == 3
                  ? Obx(() => Column(
                        children: [
                          controller.cloth1.value.isEmpty
                              ? SizedBox.shrink()
                              : Text('Size :${controller.cloth1.value} '),
                          controller.cloth2.value.isEmpty
                              ? SizedBox.shrink()
                              : Text('Color :${controller.cloth2.value}, '),
                          controller.cloth3.value.isEmpty
                              ? SizedBox.shrink()
                              : Text('Fabric Type :${controller.cloth3.value}'),
                        ],
                      ))
                  : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: getDetails().isEmpty
                  ? [const EmptyData()]
                  : getDetails()
                      .map((e) => Row(
                            children: [
                              Expanded(child: Text(e.keys.first)),
                              Expanded(
                                  child: Wrap(
                                      children: e.values
                                          .map((t) => Wrap(
                                              children: t
                                                  .map((r) => InkWell(
                                                        onTap: () {
                                                          if (typeId == 4) {
                                                            if (e.keys.first ==
                                                                'Ketchup') {
                                                              controller.food1
                                                                      .value =
                                                                  r.keys.first;
                                                              controller.food1P
                                                                      .value =
                                                                  int.parse(r
                                                                      .values
                                                                      .first
                                                                      .toString());
                                                            } else if (e.keys
                                                                    .first ==
                                                                'Pickles') {
                                                              controller.food2
                                                                      .value =
                                                                  r.keys.first;
                                                              controller.food2P
                                                                      .value =
                                                                  int.parse(r
                                                                      .values
                                                                      .first
                                                                      .toString());
                                                            } else if (e.keys
                                                                    .first ==
                                                                'Salt') {
                                                              controller.food3
                                                                      .value =
                                                                  r.keys.first;
                                                              controller.food3P
                                                                      .value =
                                                                  int.parse(r
                                                                      .values
                                                                      .first
                                                                      .toString());
                                                            } else {
                                                              controller.food4
                                                                      .value =
                                                                  r.keys.first;
                                                              controller.food4P
                                                                      .value =
                                                                  int.parse(r
                                                                      .values
                                                                      .first
                                                                      .toString());
                                                            }
                                                          } else if (typeId ==
                                                              3) {
                                                            if (e.keys.first ==
                                                                'Size') {
                                                              controller.cloth1
                                                                      .value =
                                                                  r.keys.first;
                                                              controller.cloth1P
                                                                      .value =
                                                                  int.parse(r
                                                                      .values
                                                                      .first
                                                                      .toString());
                                                            } else if (e.keys
                                                                    .first ==
                                                                'Color') {
                                                              controller.cloth2
                                                                      .value =
                                                                  r.keys.first;
                                                              controller.cloth2P
                                                                      .value =
                                                                  int.parse(r
                                                                      .values
                                                                      .first
                                                                      .toString());
                                                            } else {
                                                              controller.cloth3
                                                                      .value =
                                                                  r.keys.first;
                                                              controller.cloth3P
                                                                      .value =
                                                                  int.parse(r
                                                                      .values
                                                                      .first
                                                                      .toString());
                                                            }
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3),
                                                          child: Chip(
                                                              label: Column(
                                                            children: [
                                                              Text(
                                                                  r.keys.first),
                                                              Text(r
                                                                  .values.first
                                                                  .toString()),
                                                            ],
                                                          )),
                                                        ),
                                                      ))
                                                  .toList()))
                                          .toList()))
                            ],
                          ))
                      .toList(),
            ),
          ),
          FloatingActionButton.extended(
              backgroundColor: Colors.purple.shade200,
              isExtended: true,
              onPressed: () async {
                if (typeId == 4) {
                  controller.descr.assign(id!,
                      'Ketchup :${controller.food1.value},Pickles :${controller.food2.value}, Salt :${controller.food3.value} French fries :${controller.food4.value}');
                  controller.totalPriceDetails.value = controller.food1P.value +
                      controller.food2P.value +
                      controller.food3P.value +
                      controller.food4P.value;
                  controller.food1P.value = 0;
                  controller.food2P.value = 0;
                  controller.food3P.value = 0;
                  controller.food4P.value = 0;
                  controller.food1.value = '';
                  controller.food2.value = '';
                  controller.food3.value = '';
                  controller.food4.value = '';
                } else if (typeId == 3) {
                  controller.descr.assign(id!,
                      'Size :${controller.cloth1.value},Color :${controller.cloth2.value}, Fabric Type :${controller.cloth3.value}');

                  controller.totalPriceDetails.value =
                      controller.cloth1P.value +
                          controller.cloth2P.value +
                          controller.cloth3P.value;
                  controller.cloth1P.value = 0;
                  controller.cloth2P.value = 0;
                  controller.cloth3P.value = 0;
                  controller.food1.value = '';
                  controller.cloth1.value = '';
                  controller.cloth2.value = '';
                  controller.cloth3.value = '';
                } else {
                  controller.descr.assign(id!, 'No Details');
                }
                Overlayment.dismissLast();
              },
              label: SizedBox(
                  height: Get.height / 3,
                  child: Center(
                      child: Text(
                    'done'.tr,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ))))
        ],
      ),
    );
  }

  List<Map<String, List<Map<String, int>>>> getDetails() => typeId == 4
      ? [
          {
            'Ketchup': [
              {'Extra': 120},
              {'Normal': 80},
              {'Small': 40},
              {'none': 0}
            ],
          },
          {
            'Pickles': [
              {'Extra': 50},
              {'Normal': 22},
              {'Small': 10},
              {'none': 0}
            ],
          },
          {
            'Salt': [
              {'Extra': 10},
              {'Normal': 5},
              {'Small': 1},
              {'none': 0}
            ],
          },
          {
            'French fries': [
              {'Extra': 20000},
              {'Normal': 15000},
              {'Small': 5000},
              {'none': 0}
            ]
          }
        ]
      : typeId == 3
          ? [
              {
                'Size': [
                  {'Extra': 450},
                  {'Normal': 200},
                  {'Small': 100},
                  {'none': 0}
                ],
              },
              {
                'Color': [
                  {'Red': 50},
                  {'Blue': 50},
                  {'Yellow': 50},
                  {'White': 50}
                ],
              },
              {
                'Fabric Type': [
                  {'High': 1000},
                  {'Normal': 500},
                  {'Good': 200}
                ]
              }
            ]
          : [];
}
