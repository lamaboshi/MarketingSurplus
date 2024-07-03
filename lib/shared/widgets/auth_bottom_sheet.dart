import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/routes/app_routes.dart';

class AuthBottomSheet {
  Future<void> modalBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 200,
            color: Colors.transparent,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Center(
                  child: SizedBox(
                    width: Get.width / 1.8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No Auth',
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.purple.shade200,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                  'You Cannot Access to This Tap IF you want to Tap it Plase LogIn / Sign Up'),
                              const SizedBox(
                                height: 15,
                              ),
                              FloatingActionButton.extended(
                                  backgroundColor: Colors.purple.shade200,
                                  isExtended: true,
                                  onPressed: () async {
                                    await Get.rootDelegate
                                        .offAndToNamed(Paths.LogIn);
                                  },
                                  label: SizedBox(
                                      width: Get.width / 3,
                                      child: const Center(
                                          child: Text(
                                        'LogIn',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ))))
                            ],
                          ),
                          const SizedBox()
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }
}
