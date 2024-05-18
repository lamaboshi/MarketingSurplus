import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/routes/app_routes.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';

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

  Future<void> modalBasketBottomSheet(BuildContext context) async {
    var data = Get.find<AuthService>().getDataBasket();
    await showModalBottomSheet(
        context: context,
        builder: (builder) {
          var amount = 1.obs;
          return Container(
            height: 400,
            color: Colors.transparent,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Basket',
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.purple.shade200,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: data.map((e) {
                          return ListTile(
                            title: Text(e.product!.name ?? ''),
                            trailing: Obx(
                              () => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        amount = amount + 1;
                                        if (amount <= e.amount!) {
                                          e.amountApp = amount.value;

                                          print(e.amountApp.toString());
                                        } else {
                                          amount.value = e.amount!;
                                        }
                                      },
                                      child: const Icon(Icons.add)),
                                  Text(amount.value.toString()),
                                  TextButton(
                                      onPressed: () {
                                        amount = amount - 1;
                                        if (amount > 0) {
                                          e.amountApp = amount.value;
                                          print(e.amountApp.toString());
                                        } else {
                                          amount.value = 1;
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
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
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
                                Text(
                                  e.product!.oldPrice != null
                                      ? e.product!.oldPrice.toString()
                                      : '',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
