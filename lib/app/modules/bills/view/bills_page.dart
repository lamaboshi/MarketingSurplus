import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';

import '../../../../shared/service/auth_service.dart';

class BillsView extends GetView<BillsController> {
  const BillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Obx(
          () => controller.list.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Basket Item',
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.purple.shade200,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        children: controller.list.map((e) {
                          return Card(
                            child: ListTile(
                              title: Text(e.product!.name ?? ''),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        if (e.amountApp! < e.amount!) {
                                          e.amountApp = e.amountApp! + 1;
                                          print(e.amountApp.toString());
                                          controller.list.refresh();
                                        }
                                      },
                                      child: const Icon(Icons.add)),
                                  Text(e.amountApp!.toString()),
                                  TextButton(
                                      onPressed: () {
                                        if (e.amountApp! > 0) {
                                          e.amountApp = e.amountApp! - 1;
                                          print(e.amountApp.toString());
                                          controller.list.refresh();
                                          if (e.amountApp == 0) {
                                            Get.find<AuthService>()
                                                .deleteFromBasket(e);
                                            controller.getData();
                                          }
                                        }
                                      },
                                      child: const Icon(Icons.minimize)),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      Get.find<AuthService>()
                                          .deleteFromBasket(e);
                                    },
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.product!.price != null
                                      ? e.product!.price.toString()
                                      : ''),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        e.product!.oldPrice != null
                                            ? e.product!.oldPrice.toString()
                                            : '',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Chip(
                                          side: BorderSide(
                                              color: Colors.green.shade400),
                                          backgroundColor:
                                              Colors.green.shade400,
                                          labelPadding: const EdgeInsets.all(2),
                                          label: Text(
                                            e.amount != null
                                                ? e.amount.toString()
                                                : '0',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Chip(
                                          side: BorderSide(
                                              color: Colors.red.shade400),
                                          backgroundColor: Colors.red.shade400,
                                          labelPadding: const EdgeInsets.all(2),
                                          label: Text(
                                            '${getPercentage(e.product!.oldPrice!, e.product!.price!)}%',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'No Item added yet',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'choice Item from a store to add it to your',
                          ),
                          Text(
                            'favorites and it will show up here',
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: SizedBox(
                        height: 140,
                        width: 350,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  child: SizedBox(
                                    height: 100,
                                    width: 350,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Obx(
                                                () => Icon(
                                                  Icons.favorite,
                                                  color: controller
                                                      .currentColor.value,
                                                ),
                                              )),
                                          const Align(
                                              alignment: Alignment.topLeft,
                                              child: Icon(
                                                Icons.circle,
                                                color: Colors.white,
                                                size: 50,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            Expanded(
                                child: Container(
                              color: Colors.white,
                              child: const SizedBox(
                                height: 40,
                                width: 350,
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple.shade200,
                            shape: const StadiumBorder()),
                        child: const SizedBox(
                          width: 150,
                          height: 50,
                          child: Center(
                            child: Text(
                              'Find a Surprise Bag',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                    const SizedBox()
                  ],
                ),
        ));
  }

  double getPercentage(double p1, double p2) => ((p1 / p2) - p1) * 100;
}
