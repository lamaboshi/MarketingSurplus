import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/setting_profile/controller/setting_profile_controller.dart';
import 'package:overlayment/overlayment.dart';

import 'profile_details.dart';

class SettingProfileView extends GetView<SettingProfileController> {
  const SettingProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          // UserAccountsDrawerHeader(
          //   accountName: const Text(
          //     "ghazal",
          //     style: TextStyle(fontSize: 20.0, color: Colors.black),
          //   ),
          //   accountEmail: const Text(
          //     'ghazal@gmail.com',
          //     style: TextStyle(fontSize: 20.0, color: Colors.grey),
          //   ),
          //   currentAccountPicture: GestureDetector(
          //     child: const CircleAvatar(
          //       backgroundColor: Colors.purple,
          //       child: Icon(
          //         Icons.person,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          //   decoration: BoxDecoration(color: Colors.grey[100]),
          // ),
          SectionWidget(
            title: 'SETTING',
            widget: const [
              'Account details',
              'Payment cards',
              'vouchers',
              'Notification',
              'Delete My Account'
            ],
            onTabs: [
              () {
                Get.to(const ProfileDetails());
              },
              () {},
              () {},
              () {},
              () async {
                Overlayment.show(OverDialog(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Delete Acount !!'),
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
              Icons.notifications,
              Icons.person_off_outlined
            ],
          ),
          SectionWidget(
            title: 'COMMUNITY',
            widget: const [
              'Recommend a store',
              'sign up your store',
            ],
            onTabs: [() {}, () {}],
            icons: const [Icons.comment_outlined, Icons.store],
          ),
          SectionWidget(
            title: 'SUPPORT',
            widget: const [
              'Help with an order',
              'How clean out work',
              'join to Clean out',
            ],
            onTabs: [() {}, () {}, () {}],
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
