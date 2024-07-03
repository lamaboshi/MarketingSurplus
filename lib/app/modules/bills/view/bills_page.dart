import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';
import 'package:marketing_surplus/app/modules/home/controller/home_controller.dart';
import 'package:marketing_surplus/shared/service/order_service.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../routes/app_routes.dart';
import '../../order/controller/order_controller.dart';
import '../../order/view/order_page.dart';
import 'order_details_page.dart';

class BillsView extends GetView<BillsController> {
  const BillsView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getData();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: !controller.auth.isAuth()
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_bag,
                        size: 65,
                        color: Colors.purple.shade200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('youshould-title'.tr),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.rootDelegate.toNamed(Paths.SignUpUserPage);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple.shade200,
                            shape: const StadiumBorder()),
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: Center(
                            child: Text(
                              'singup-title'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'order-title'.tr,
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.purple.shade200,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => Column(
                        children: controller.orderProducts
                            .map((order) => Column(
                                  children: [
                                    Card(
                                      child: InkWell(
                                        onTap: () {
                                          Overlayment.show(OverDialog(
                                              child: OrderDetailsPage(
                                            orderProduct: order,
                                          )));
                                        },
                                        child: ListTile(
                                          title: Row(
                                            children: [
                                              Text('ordername-title'.tr),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(order.order!.name ?? ''),
                                            ],
                                          ),
                                          trailing: Text(
                                            order.totalPrice != null
                                                ? order.totalPrice.toString()
                                                : '',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('orderdes-title'.tr),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  SizedBox(
                                                    width: 130,
                                                    height: 20,
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            order.order!
                                                                    .descripation ??
                                                                '',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Text('orderstat-title'.tr),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Chip(
                                                      side: const BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                      backgroundColor: Colors
                                                          .purple.shade200,
                                                      label: Text(
                                                        getStatus(order),
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                            .toList()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'basket-title'.tr,
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.purple.shade200,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => controller.list.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
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
                                                  if (e.amountApp! <
                                                      e.amount!) {
                                                    e.amountApp =
                                                        e.amountApp! + 1;
                                                    print(
                                                        e.amountApp.toString());
                                                    controller.list.refresh();
                                                  }
                                                },
                                                child: const Icon(Icons.add)),
                                            Text(e.amountApp!.toString()),
                                            TextButton(
                                                onPressed: () async {
                                                  if (e.amountApp! > 0) {
                                                    e.amountApp =
                                                        e.amountApp! - 1;

                                                    controller.list.refresh();
                                                    if (e.amountApp == 0) {
                                                      await Get.find<
                                                              AuthService>()
                                                          .deleteFromBasket(e);
                                                      controller.getData();
                                                    }
                                                  }
                                                },
                                                child:
                                                    const Icon(Icons.minimize)),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () async {
                                                final data = await Get.find<
                                                        AuthService>()
                                                    .deleteFromBasket(e);
                                                controller.list.assignAll(data);
                                              },
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(e.product!.newPrice != null
                                                ? e.product!.newPrice.toString()
                                                : ''),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  e.product!.oldPrice != null
                                                      ? e.product!.oldPrice
                                                          .toString()
                                                      : '',
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Chip(
                                                    side: BorderSide(
                                                        color: Colors
                                                            .green.shade400),
                                                    backgroundColor:
                                                        Colors.green.shade400,
                                                    labelPadding:
                                                        const EdgeInsets.all(2),
                                                    label: Text(
                                                      e.amount != null
                                                          ? e.amount.toString()
                                                          : '0',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Obx(
                                                          () => Icon(
                                                            Icons.shopping_cart,
                                                            color: controller
                                                                .currentColor
                                                                .value,
                                                          ),
                                                        )),
                                                    const Align(
                                                        alignment:
                                                            Alignment.topLeft,
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
                                  onPressed: () {
                                    Get.find<HomeController>().pageIndex.value =
                                        1;
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple.shade200,
                                      shape: const StadiumBorder()),
                                  child: SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        'find-title'.tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                              const SizedBox()
                            ],
                          ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.purple.shade200,
          isExtended: true,
          onPressed: () async {
            controller.assignAllAmount();
            if (controller.list.isNotEmpty) {
              if (Get.isRegistered<OrderController>()) {
                final orderController = Get.find<OrderController>();
                orderController.onInit();
              } else {
                Get.put(OrderController());
              }

              Overlayment.show(OverPanel(
                child: const OrderView(),
                alignment: Alignment.topCenter,
              ));
            } else {
              var snackBar = SnackBar(
                  duration: Duration(seconds: 1),
                  content: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      'Your Bag Is Empty',
                      style: TextStyle(
                          color: Colors.purple.shade200, fontSize: 18),
                    ),
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          label: SizedBox(
              height: Get.height / 3,
              child: const Center(
                  child: Text(
                'Buy',
                style: TextStyle(fontSize: 18, color: Colors.white),
              )))),
    );
  }

  double getPercentage(double p1, double p2) => ((p1 / p2) - p1) * 100;

  String getStatus(OrderProduct orderProduct) {
    var bills = orderProduct.bills!.last.orderStatusId!;
    return OrderStutas.values[bills].name;
  }
}
