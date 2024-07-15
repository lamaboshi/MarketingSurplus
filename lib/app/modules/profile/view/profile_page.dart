import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/routes/app_routes.dart';

import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../../shared/widgets/section_widget.dart';
import '../controller/profile_controller.dart';
import 'last_order_charity.dart';
import 'last_order_user.dart';
import 'product_exp.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getData();
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
          : Column(
              children: [
                SectionWidget(
                  flex: 1,
                  icon: Icons.local_fire_department_rounded,
                  title: 'Features'.tr,
                  child: Row(
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
                            child: Text(controller.banfi[controller.value.value]
                                .entries.first.value),
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Row(
                                                        children: [
                                                          Text('old-price'.tr),
                                                          Text(
                                                              ' ${element.entries.first.key}'),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Row(
                                                        children: [
                                                          Text('tot-price'.tr),
                                                          Text(
                                                              ' ${element.entries.first.value}'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Row(
                                                    children: [
                                                      Text('result'.tr),
                                                      Text(
                                                          ' ${(element.entries.first.key - element.entries.first.value)}'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ))
                                        .toList(),
                                  ),
                                  Divider(
                                    color: Colors.purple.shade200,
                                  ),
                                  Row(
                                    children: [
                                      Text('all-save'.tr),
                                      Text(
                                          ' ${controller.saved.value.toString()}'),
                                    ],
                                  )
                                ],
                              ),
                            )));
                          }),
                        ),
                      )
                    ],
                  ),
                ),
                SectionWidget(
                  flex: 2,
                  icon: Icons.layers_outlined,
                  title: 'lastord-title'.tr,
                  child: controller.auth.getTypeEnum() == Auth.user
                      ? LastOrderUser(
                          isLast: true,
                        )
                      : controller.auth.getTypeEnum() == Auth.charity
                          ? LastOrderCharity()
                          : ProductExpiration(),
                )
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.purple.shade200),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(color: Colors.purple.shade200),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
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
