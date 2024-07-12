import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/setting_profile/controller/setting_profile_controller.dart';
import 'package:marketing_surplus/app/modules/setting_profile/view/widget/pay_method_widget.dart';
import 'package:overlayment/overlayment.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../routes/app_routes.dart';
import 'profile_details.dart';
import 'widget/company_users_page.dart';
import 'widget/help_order.dart';
import 'widget/join_page.dart';
import 'widget/order_bills_widget.dart';
import 'widget/order_type_page.dart';
import 'widget/work_way_page.dart';

class SettingProfileView extends GetView<SettingProfileController> {
  const SettingProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ToggleSwitch(
            minWidth: 70.0,
            cornerRadius: 20.0,
            activeBgColors: [
              [Colors.purple.shade200],
              [Colors.purple.shade200]
            ],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey.shade300,
            inactiveFgColor: Colors.purple.shade200,
            initialLabelIndex: 1,
            totalSwitches: 2,
            labels: controller.listTextTabToggle,
            radiusStyle: true,
            onToggle: (index) {
              controller.toggle(index!);
            },
          ),
        ],
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.purple.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(40))),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Clout',
              style: TextStyle(
                  color: Colors.purple.shade200,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          SectionWidget(
            title: 'seting-title'.tr,
            widget: controller.auth.getTypeEnum() != Auth.charity
                ? [
                    'accdea-title'.tr,
                    'paycar-title'.tr,
                    'vou-title'.tr,
                    'del-title'.tr
                  ]
                : [
                    'accdea-title'.tr,
                    'order-type'.tr,
                    'vou-title'.tr,
                    'del-title'.tr
                  ],
            onTabs: [
              () {
                Get.to(const ProfileDetails());
              },
              () {
                if (controller.auth.getTypeEnum() == Auth.charity) {
                  Overlayment.show(OverPanel(child: const OrderTypeView()));
                } else {
                  Overlayment.show(OverPanel(child: const PayMethodView()));
                }
              },
              () {
                Overlayment.show(OverPanel(child: const OrderBillsWidget()));
              },
              () async {
                Overlayment.show(OverDialog(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('delacc-title'.tr),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () async {
                            await controller.deleteAccount();
                          },
                          child: const Text('Yes'))
                    ],
                  ),
                )));
              }
            ],
            icons: const [
              Icons.account_circle_outlined,
              Icons.payment,
              Icons.vertical_distribute_sharp,
              Icons.person_off_outlined
            ],
          ),
          SectionWidget(
            title: 'com-title'.tr,
            widget: controller.auth.getTypeEnum() == Auth.comapny
                ? ['user-sub'.tr, 'sign-user'.tr]
                : [
                    'rec-title'.tr,
                    'sing-title'.tr,
                  ],
            onTabs: controller.auth.getTypeEnum() == Auth.comapny
                ? [
                    () {
                      Overlayment.show(OverPanel(child: CompanyUsersPage()));
                    },
                    () {
                      Get.rootDelegate.offAndToNamed(Paths.SignUpUserPage);
                    }
                  ]
                : [
                    () {},
                    () {
                      Get.rootDelegate.offAndToNamed(Paths.SignUpUserPage);
                    }
                  ],
            icons: controller.auth.getTypeEnum() == Auth.comapny
                ? [Icons.people, Icons.person_2]
                : const [Icons.comment_outlined, Icons.store],
          ),
          SectionWidget(
            title: 'sup-title'.tr,
            widget: [
              'help-title'.tr,
              'howcl-title'.tr,
              'joinup-title'.tr,
            ],
            onTabs: [
              () {
                Get.to(HelpOrder());
              },
              () {
                Get.to(WorkWayPage());
              },
              () {
                Get.to(JoinPage());
              }
            ],
            icons: const [
              Icons.shopify_outlined,
              Icons.help_outline_rounded,
              Icons.person_add_alt
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SectionWidget extends StatelessWidget {
  List<String> widget;
  List<IconData> icons;
  List<VoidCallback> onTabs;
  String title;
  SectionWidget(
      {super.key,
      required this.widget,
      required this.title,
      required this.onTabs,
      required this.icons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
          Column(
              children: widget.map((e) {
            final index = widget.indexOf(e);
            return ListTile(
                onTap: onTabs[index],
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  e,
                ),
                leading: Icon(
                  icons[index],
                  color: Colors.purple.shade200,
                ));
          }).toList()),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
