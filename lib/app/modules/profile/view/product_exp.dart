import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/charity/controller/charity_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/widgets/empty_screen.dart';
import '../../../../shared/widgets/single_item_product.dart';
import '../../../../shared/widgets/textfield_widget.dart';
import '../../home/controller/home_controller.dart';
import '../controller/profile_controller.dart';

class ProductExpiration extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.products.isEmpty
        ? EmptyData()
        : SingleChildScrollView(
            child: Column(
                children: controller.products
                    .map((element) => SingleItem(
                          element,
                          false,
                          () {},
                          () async {
                            controller.newProduct.value = element.product!;
                            await showModalBottomSheet(
                                context: context,
                                builder: (builder) => SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            color: Colors.purple.shade200,
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Edit Product',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                TextFieldWidget(
                                                  label: controller.newProduct
                                                          .value.name ??
                                                      'Name Product',
                                                  onChanged: (value) {
                                                    controller.newProduct.value
                                                        .name = value;
                                                  },
                                                  textInputType:
                                                      TextInputType.text,
                                                ),
                                                TextFieldWidget(
                                                  label: controller.newProduct
                                                          .value.descripation ??
                                                      'Descripation Product',
                                                  onChanged: (value) {
                                                    controller.newProduct.value
                                                        .descripation = value;
                                                  },
                                                  textInputType:
                                                      TextInputType.text,
                                                ),
                                                TextFieldWidget(
                                                  label: controller.newProduct
                                                              .value.oldPrice !=
                                                          null
                                                      ? controller.newProduct
                                                          .value.oldPrice
                                                          .toString()
                                                      : 'Old Price Product',
                                                  onChanged: (value) {
                                                    controller.newProduct.value
                                                            .oldPrice =
                                                        double.tryParse(value);
                                                  },
                                                  textInputType:
                                                      TextInputType.text,
                                                ),
                                                TextFieldWidget(
                                                  label: controller.newProduct
                                                              .value.newPrice !=
                                                          null
                                                      ? controller.newProduct
                                                          .value.newPrice
                                                          .toString()
                                                      : 'offer Price Product',
                                                  onChanged: (value) {
                                                    controller.newProduct.value
                                                            .newPrice =
                                                        double.tryParse(value);
                                                  },
                                                  textInputType:
                                                      TextInputType.text,
                                                ),
                                                TextFieldWidget(
                                                  label:
                                                      'Amount  this  Product',
                                                  onChanged: (value) {
                                                    controller.amount.value =
                                                        int.parse(value);
                                                  },
                                                  textInputType:
                                                      TextInputType.text,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Create Date Product',
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        height: 120,
                                                        child:
                                                            CupertinoDatePicker(
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .date,
                                                          initialDateTime:
                                                              controller
                                                                      .newProduct
                                                                      .value
                                                                      .dateTime ??
                                                                  DateTime
                                                                      .now(),
                                                          onDateTimeChanged:
                                                              (DateTime
                                                                  newDateTime) {
                                                            controller
                                                                    .newProduct
                                                                    .value
                                                                    .dateTime =
                                                                newDateTime;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Expiration Date Product',
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        height: 120,
                                                        child:
                                                            CupertinoDatePicker(
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .date,
                                                          initialDateTime: controller
                                                                  .newProduct
                                                                  .value
                                                                  .expiration ??
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: FloatingActionButton
                                                      .extended(
                                                          backgroundColor:
                                                              Colors.purple
                                                                  .shade200,
                                                          isExtended: true,
                                                          onPressed: () async {
                                                            final rsult =
                                                                await controller
                                                                    .addProduct();
                                                            if (rsult) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          },
                                                          label: SizedBox(
                                                              width:
                                                                  Get.width / 3,
                                                              child:
                                                                  const Center(
                                                                      child:
                                                                          Text(
                                                                'Add',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
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
                                        ],
                                      ),
                                    ));
                          },
                          () {
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
                                          onPressed: () {}, child: Text("yes")),
                                      TextButton(
                                          onPressed: () {
                                            Overlayment.dismissLast();
                                          },
                                          child: Text("no")),
                                    ],
                                  )
                                ],
                              ),
                            )));
                          },
                          !controller.auth.isAuth(),
                          without: true,
                          widget: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.purple.shade200)),
                            child: Text(
                              'Donation',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              final controlCharity =
                                  Get.find<CharityController>();
                              controlCharity.toPayProduct.add(element);
                              Overlayment.show(OverDialog(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      'The Item Addded in list To Dontain Do You want to Contun and Select Charity To Donation ?!'),
                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Overlayment.dismissLast();
                                            Get.find<HomeController>()
                                                .pageIndex
                                                .value = 2;
                                          },
                                          child: Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            controlCharity.toPayProduct.clear();
                                            Overlayment.dismissLast();
                                          },
                                          child: Text('No'))
                                    ],
                                  )
                                ],
                              )));
                            },
                          ),
                        ))
                    .toList()),
          ));
  }
}
