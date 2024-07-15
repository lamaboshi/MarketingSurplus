import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';
import 'package:marketing_surplus/shared/service/order_service.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../../shared/widgets/empty_screen.dart';
import '../../../routes/app_routes.dart';
import '../../order/controller/order_controller.dart';
import '../../order/view/order_charity_page.dart';
import '../../order/view/order_page.dart';
import '../../profile/view/last_order_charity.dart';
import '../../profile/view/last_order_user.dart';

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
                          Get.rootDelegate.history.clear();
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
          : RefreshIndicator(
              onRefresh: () async {
                controller.onInit();
              },
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                          const Divider(),
                          Obx(() => controller.list.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
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

                                                        controller.list
                                                            .refresh();
                                                      }
                                                    },
                                                    child:
                                                        const Icon(Icons.add)),
                                                Text(e.amountApp!.toString()),
                                                TextButton(
                                                    onPressed: () async {
                                                      if (e.amountApp! > 0) {
                                                        e.amountApp =
                                                            e.amountApp! - 1;

                                                        controller.list
                                                            .refresh();
                                                        if (e.amountApp == 0) {
                                                          await Get.find<
                                                                  AuthService>()
                                                              .deleteFromBasket(
                                                                  e);
                                                          controller.getData();
                                                        }
                                                      }
                                                    },
                                                    child: const Icon(
                                                        Icons.minimize)),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () async {
                                                    final data = await Get.find<
                                                            AuthService>()
                                                        .deleteFromBasket(e);
                                                    controller.list
                                                        .assignAll(data);
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
                                                    ? e.product!.newPrice
                                                        .toString()
                                                    : ''),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      e.product!.oldPrice !=
                                                              null
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
                                                            color: Colors.green
                                                                .shade400),
                                                        backgroundColor: Colors
                                                            .green.shade400,
                                                        labelPadding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        label: Text(
                                                          e.amount != null
                                                              ? e.amount
                                                                  .toString()
                                                              : '0',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                              : const EmptyBasket()),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
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
                        const Divider(),
                        controller.auth.getTypeEnum() == Auth.user
                            ? const LastOrderUser(
                                isLast: false,
                              )
                            : controller.auth.getTypeEnum() == Auth.charity
                                ? const LastOrderCharity()
                                : const SizedBox.shrink(),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )),
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
              if (controller.auth.getTypeEnum() == Auth.charity) {
                Overlayment.show(OverPanel(
                  child: const OrderCharityPage(),
                  alignment: Alignment.topCenter,
                ));
              } else {
                Overlayment.show(OverPanel(
                  child: const OrderView(),
                  alignment: Alignment.topCenter,
                ));
              }
            } else {
              var snackBar = SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      'bag-em'.tr,
                      style: TextStyle(
                          color: Colors.purple.shade200, fontSize: 18),
                    ),
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          label: SizedBox(
              height: Get.height / 3,
              child: Center(
                  child: Text(
                'buy'.tr,
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
