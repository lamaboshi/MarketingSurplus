import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/textfield_widget.dart';
import '../controller/home_controller.dart';

class MainCompanyPage extends GetView<HomeController> {
  const MainCompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _SectionWidget(
                title: 'lastord-title'.tr,
                icon: Icons.shopping_bag_rounded,
                child: Obx(
                  () => Wrap(
                    children: controller.orders
                        .map(
                          (element) => Card(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withOpacity(0.5),
                            child: ListTile(
                              title: Text(
                                element.name ?? '',
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    'amount-title'.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    element.amount.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'price-title'.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    element.price.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )),
            _SectionWidget(
                title: 'ratecus-title'.tr,
                icon: Icons.data_exploration_sharp,
                child: Obx(
                  () => Wrap(
                    children: controller.rates
                        .map(
                          (element) => Card(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withOpacity(0.5),
                            child: ListTile(
                              title: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    element.rateNumber.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )),
            _SectionWidget(
              title: 'mostpop-title'.tr,
              icon: Icons.star_purple500_outlined,
              child: Obx(
                () => Wrap(
                  children: controller.products
                      .map(
                        (element) => Card(
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(0.5),
                          child: ListTile(
                            title: Text(
                              element.product!.name ?? "",
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  'price-title'.tr,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  element.product!.newPrice.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
              context: context,
              builder: (builder) => SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: Colors.purple.shade200,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'addpro-title',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFieldWidget(
                                label: 'namepro-title'.tr,
                                onChanged: (value) {
                                  controller.newProduct.value.name = value;
                                },
                                textInputType: TextInputType.text,
                              ),
                              TextFieldWidget(
                                label: 'despro-title'.tr,
                                onChanged: (value) {
                                  controller.newProduct.value.descripation =
                                      value;
                                },
                                textInputType: TextInputType.text,
                              ),
                              TextFieldWidget(
                                label: 'oldpri-title'.tr,
                                onChanged: (value) {
                                  controller.newProduct.value.oldPrice =
                                      double.tryParse(value);
                                },
                                textInputType: TextInputType.text,
                              ),
                              TextFieldWidget(
                                label: 'offerpri-title'.tr,
                                onChanged: (value) {
                                  controller.newProduct.value.newPrice =
                                      double.tryParse(value);
                                },
                                textInputType: TextInputType.text,
                              ),
                              TextFieldWidget(
                                label: 'amoutth-title'.tr,
                                onChanged: (value) {
                                  controller.amount.value = int.parse(value);
                                },
                                textInputType: TextInputType.text,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'creatda-title'.tr,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 120,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: DateTime(1969, 1, 1),
                                        onDateTimeChanged:
                                            (DateTime newDateTime) {
                                          controller.newProduct.value.dateTime =
                                              newDateTime;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'expda-title'.tr,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 120,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: DateTime(1969, 1, 1),
                                        onDateTimeChanged: (newDateTime) {
                                          controller.newProduct.value
                                              .expiration = newDateTime;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton.extended(
                                    backgroundColor: Colors.purple.shade200,
                                    isExtended: true,
                                    onPressed: () async {
                                      final rsult =
                                          await controller.addProduct();
                                      if (rsult) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    label: SizedBox(
                                        width: Get.width / 3,
                                        child: Center(
                                            child: Text(
                                          'addd-title'.tr,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )))),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.blueAccent,
          size: 35,
        ),
      ),
    );
  }
}

class _SectionWidget extends GetView<HomeController> {
  const _SectionWidget({this.title, this.icon, this.child});
  final String? title;
  final Widget? child;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  icon,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title ?? "",
                style: TextStyle(color: Colors.purple.shade300, fontSize: 21),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: child!,
        )
      ],
    );
  }
}
