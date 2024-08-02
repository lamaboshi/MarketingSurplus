import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/home/controller/home_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/util.dart';
import '../../../../shared/widgets/empty_screen.dart';
import '../../../../shared/widgets/single_item_product.dart';
import '../../../../shared/widgets/textfield_widget.dart';

class MainCompanyProduct extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.products.isEmpty
        ? EmptyData()
        : Column(
            children: controller.products
                .map((element) => SingleItem(element, true, () {}, () async {
                      controller.newProduct.value = element.product!;

                      Overlayment.show(OverDialog(
                          height: Get.height / 1.3,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  color: Colors.purple.shade200,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'editpro-title'.tr,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Obx(() => controller
                                              .stringPickImage.value.isNotEmpty
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(33),
                                                child: Utility
                                                    .imageFromBase64String(
                                                        controller
                                                            .stringPickImage
                                                            .value,
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
                                            label: 'namepro-title'.tr,
                                            value: controller
                                                    .newProduct.value.name ??
                                                '',
                                            validator: controller.forceValue,
                                            onChanged: (value) {
                                              controller.newProduct.value.name =
                                                  value;
                                            },
                                            textInputType: TextInputType.text,
                                          ),
                                          TextFieldWidget(
                                            validator: controller.forceValue,
                                            label: 'despro-title'.tr,
                                            value: controller.newProduct.value
                                                    .descripation ??
                                                '',
                                            onChanged: (value) {
                                              controller.newProduct.value
                                                  .descripation = value;
                                            },
                                            textInputType: TextInputType.text,
                                          ),
                                          TextFieldWidget(
                                            validator: controller.forceValue,
                                            label: 'oldpri-title'.tr,
                                            value: controller.newProduct.value
                                                        .oldPrice !=
                                                    null
                                                ? controller
                                                    .newProduct.value.oldPrice
                                                    .toString()
                                                : '',
                                            onChanged: (value) {
                                              controller.newProduct.value
                                                      .newPrice =
                                                  double.tryParse(value);
                                            },
                                            textInputType: TextInputType.number,
                                          ),
                                          TextFieldWidget(
                                            validator: controller.forceValue,
                                            label: 'offerpri-title'.tr,
                                            value: controller.newProduct.value
                                                        .newPrice !=
                                                    null
                                                ? controller
                                                    .newProduct.value.newPrice
                                                    .toString()
                                                : '',
                                            onChanged: (value) {
                                              controller.newProduct.value
                                                      .newPrice =
                                                  double.tryParse(value);
                                            },
                                            textInputType: TextInputType.number,
                                          ),
                                          TextFieldWidget(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'requird';
                                              } else {
                                                if (int.parse(value) < 1) {
                                                  return 'Entre Real Value';
                                                }
                                              }
                                              return null;
                                            },
                                            label: 'amoutth-title'.tr,
                                            onChanged: (value) {
                                              controller.amount.value =
                                                  int.parse(value);
                                            },
                                            textInputType: TextInputType.number,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'creatda-title'.tr,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  height: 120,
                                                  child: CupertinoDatePicker(
                                                    minimumYear: 2022,
                                                    maximumYear: 2024,
                                                    mode:
                                                        CupertinoDatePickerMode
                                                            .date,
                                                    initialDateTime:
                                                        DateTime.now(),
                                                    onDateTimeChanged:
                                                        (DateTime newDateTime) {
                                                      controller.newProduct
                                                              .value.dateTime =
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'expda-title'.tr,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  height: 120,
                                                  child: CupertinoDatePicker(
                                                    minimumYear: 2024,
                                                    maximumYear: 2027,
                                                    mode:
                                                        CupertinoDatePickerMode
                                                            .date,
                                                    initialDateTime:
                                                        DateTime.now(),
                                                    onDateTimeChanged:
                                                        (newDateTime) {
                                                      controller
                                                              .newProduct
                                                              .value
                                                              .expiration =
                                                          newDateTime;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                FloatingActionButton.extended(
                                                    backgroundColor:
                                                        Colors.purple.shade200,
                                                    isExtended: true,
                                                    onPressed: () async {
                                                      if (controller
                                                          .keyForm.currentState!
                                                          .validate()) {
                                                        final rsult =
                                                            await controller
                                                                .updateProduct();
                                                        Overlayment
                                                            .dismissLast();
                                                        if (rsult) {
                                                          Overlayment
                                                              .dismissLast();
                                                        }
                                                      }
                                                    },
                                                    label: SizedBox(
                                                        width: Get.width / 3,
                                                        child: Center(
                                                            child: Text(
                                                          'addd-title'.tr,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .white),
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
                    }, () {
                      Overlayment.show(OverDialog(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Are you sure'),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await controller
                                        .deleteProduct(element.product!.id!);
                                  },
                                  child: Text('Yes'.tr),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Overlayment.dismissLast();
                                  },
                                  child: Text('Cancel'.tr),
                                ),
                              ],
                            )
                          ],
                        ),
                      )));
                    }, !controller.auth.isAuth()))
                .toList()));
  }
}
