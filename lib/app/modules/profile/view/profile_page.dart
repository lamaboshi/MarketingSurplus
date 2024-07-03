import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/routes/app_routes.dart';
import 'package:marketing_surplus/shared/service/order_service.dart';
import 'package:overlayment/overlayment.dart';

import '../../bills/view/order_details_page.dart';
import '../controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getLastOrder();
    controller.getsaveOrder();
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
                        Icons.account_box_outlined,
                        size: 65,
                        color: Colors.purple.shade200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('shousing-title'.tr),
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
          : Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'lastord-title'.tr,
                                  style: TextStyle(fontSize: 19),
                                ),
                              ),
                              Obx(
                                () => controller.lastOrder.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          color: Colors.white,
                                          child: SizedBox(
                                            height: Get.height / 5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const SizedBox(),
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.hourglass_empty,
                                                    size: 35,
                                                  ),
                                                ),
                                                const Text(
                                                  'You don\'t have any orders yet',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors
                                                            .purple.shade200,
                                                        shape:
                                                            const StadiumBorder()),
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
                                                const SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: controller.lastOrder
                                            .map((element) => InkWell(
                                                  onTap: () {
                                                    Overlayment.show(OverDialog(
                                                        child: OrderDetailsPage(
                                                      orderProduct: element,
                                                    )));
                                                  },
                                                  child: Card(
                                                    child: ListTile(
                                                      title: Row(
                                                        children: [
                                                          const Text(
                                                              'Order Name :'),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(element.order!
                                                                  .name ??
                                                              ''),
                                                        ],
                                                      ),
                                                      trailing: Text(
                                                        element.order!.price !=
                                                                null
                                                            ? element
                                                                .order!.price
                                                                .toString()
                                                            : '',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      subtitle: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                  'Order Descripation :'),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  element.order!
                                                                          .descripation ??
                                                                      '',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                  'Order Stutes :'),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Chip(
                                                                  side:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .purple
                                                                          .shade200,
                                                                  label: Text(
                                                                    OrderStutas
                                                                        .done
                                                                        .name,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  )),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: getMinCard(
                                'you'.tr,
                                'co2-title'.tr,
                                Icons.adf_scanner_rounded,
                                controller.banfi[controller.value.value].entries
                                    .first.key, onTab: () {
                              Overlayment.show(OverDialog(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(controller
                                    .banfi[controller.value.value]
                                    .entries
                                    .first
                                    .value),
                              )));
                            }),
                          ),
                          Expanded(
                            child: Obx(
                              () => getMinCard(
                                  'money-title'.tr,
                                  'saved-title'.tr,
                                  Icons.monetization_on,
                                  '${controller.saved.value} \$', onTab: () {
                                Overlayment.show(OverDialog(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: controller.details
                                            .map((element) => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Text(
                                                              'old Price : ${element.entries.first.key}'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Text(
                                                              'Total Price : ${element.entries.first.value}'),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Text(
                                                          'Result : ${(element.entries.first.key - element.entries.first.value)}'),
                                                    ),
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                      Divider(
                                        color: Colors.purple.shade200,
                                      ),
                                      Text(
                                          'all Save : ${controller.saved.value.toString()}')
                                    ],
                                  ),
                                )));
                              }),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

Widget getMinCard(String title, String subTitle, IconData icon, String value,
    {Function? onTab}) {
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
              Text(
                title,
                style: TextStyle(color: Colors.purple.shade200),
              ),
              Text(
                subTitle,
                style: TextStyle(color: Colors.purple.shade200),
              ),
              const SizedBox(
                height: 15,
              ),
              Icon(
                icon,
                color: Colors.purple.shade200,
                size: 60,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                value,
                style: TextStyle(color: Colors.purple.shade200),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
