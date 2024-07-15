import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/util.dart';
import '../../../../shared/widgets/empty_screen.dart';
import '../../../../shared/widgets/section_widget.dart';
import '../../../../shared/widgets/textfield_widget.dart';
import '../controller/home_controller.dart';
import 'main_compnay_product.dart';

class MainCompanyPage extends GetView<HomeController> {
  const MainCompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          SectionWidget(
              flex: 3,
              title: 'itemcomp-title'.tr,
              icon: Icons.shopping_bag_rounded,
              child: SingleChildScrollView(
                child: MainCompanyProduct(),
              )),
          SectionWidget(
              flex: 1,
              title: 'ratecus-title'.tr,
              icon: Icons.data_exploration_sharp,
              child: SingleChildScrollView(
                child: Obx(
                  () => controller.rates.isEmpty
                      ? EmptyData()
                      : Wrap(
                          children: controller.rates
                              .map(
                                (element) => Card(
                                  color: Color((math.Random().nextDouble() *
                                              0xFFFFFF)
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
                                          element.rate!.rateNumber.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          element.rate!.description ?? '',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
              )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Overlayment.show(OverDialog(
              height: Get.height / 1.3,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.purple.shade200,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'addpro-title'.tr,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        await controller.pickImageFun();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Obx(() => controller.stringPickImage.value.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(33),
                                    child: Utility.imageFromBase64String(
                                        controller.stringPickImage.value,
                                        75,
                                        150),
                                  ),
                                )
                              : Icon(
                                  Icons.image,
                                  size: 50,
                                )),
                          const SizedBox(
                            height: 5,
                          ),
                          Center(child: Text('Addanimage'.tr)),
                        ],
                      ),
                    ),
                    Form(
                      key: controller.keyForm,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              TextFieldWidget(
                                validator: controller.forceValue,
                                label: 'namepro-title'.tr,
                                onChanged: (value) {
                                  controller.newProduct.value.name = value;
                                },
                                textInputType: TextInputType.text,
                              ),
                              TextFieldWidget(
                                validator: controller.forceValue,
                                label: 'despro-title'.tr,
                                onChanged: (value) {
                                  controller.newProduct.value.descripation =
                                      value;
                                },
                                textInputType: TextInputType.text,
                              ),
                              TextFieldWidget(
                                validator: controller.forceValue,
                                label: 'oldpri-title'.tr,
                                onChanged: (value) {
                                  controller.newProduct.value.oldPrice =
                                      double.tryParse(value);
                                },
                                textInputType: TextInputType.text,
                              ),
                              TextFieldWidget(
                                validator: controller.forceValue,
                                label: 'offerpri-title'.tr,
                                onChanged: (value) {
                                  controller.newProduct.value.newPrice =
                                      double.tryParse(value);
                                },
                                textInputType: TextInputType.number,
                              ),
                              TextFieldWidget(
                                validator: controller.forceValue,
                                label: 'amoutth-title'.tr,
                                onChanged: (value) {
                                  controller.amount.value = int.parse(value);
                                },
                                textInputType: TextInputType.number,
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
                                        minimumYear: 2022,
                                        maximumYear: 2026,
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: DateTime.now(),
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
                                        minimumYear: 2022,
                                        maximumYear: 2026,
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: DateTime.now(),
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
                                      if (controller.keyForm.currentState!
                                          .validate()) {
                                        final rsult =
                                            await controller.addProduct();
                                        Overlayment.dismissLast();
                                        if (rsult) {
                                          Overlayment.dismissLast();
                                        }
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
                      ),
                    ),
                  ],
                ),
              )));
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
