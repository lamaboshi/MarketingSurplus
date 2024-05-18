import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              child: SizedBox(
                height: Get.height / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: getMinCard('CO2e', 'avoided', Icons.adf_scanner_rounded,
                    '0\n Cupe Coffe'),
              ),
              Expanded(
                child: getMinCard(
                    'Money', 'saved', Icons.monetization_on, '0\n USD'),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget getMinCard(String title, String subTitle, IconData icon, String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
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
              subTitle,
              style: TextStyle(color: Colors.purple.shade200),
            ),
          ],
        ),
      ),
    ),
  );
}
