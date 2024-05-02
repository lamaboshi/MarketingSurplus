import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/admin/controller/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple.shade200,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: const StadiumBorder()),
                                    child: SizedBox(
                                      width: 150,
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          'Settings',
                                          style: TextStyle(
                                              color: Colors.purple.shade200,
                                              fontSize: 19),
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: const StadiumBorder()),
                                    child: SizedBox(
                                      width: 150,
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          'Notification',
                                          style: TextStyle(
                                              color: Colors.purple.shade200,
                                              fontSize: 19),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'Clean Out',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'LEST\' FIGHT FOOD WASTE TOGETHER',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 23),
                                  ),
                                  Text(
                                    'Food waste is a big problem, and we can be a solution.',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 21),
                                  ),
                                  Text(
                                    ' Clean Out is the app that lets you rescue unsold food at your favorite spots from an untimely fate.',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Obx(() => Column(
                    children: [
                      controller.getTypeResource(),
                      Column(
                        children: controller.listTabs
                            .map(
                              (e) => ListTile(
                                title: ElevatedButton(
                                    onPressed: () {
                                      final index =
                                          controller.listTabs.indexOf(e);
                                      final res =
                                          controller.setResourceEnum(index);
                                      if (res ==
                                          controller.setResourceEnum(index)) {
                                        controller.typeRsource.value =
                                            Resource.non;
                                      }
                                      controller.typeRsource.value = res;
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: const StadiumBorder()),
                                    child: SizedBox(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                              color: Colors.purple.shade200,
                                              fontSize: 19),
                                        ),
                                      ),
                                    )),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  )),
            ],
          ),
        ));
  }
}
