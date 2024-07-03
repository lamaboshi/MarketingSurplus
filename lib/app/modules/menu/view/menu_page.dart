import 'package:badges/badges.dart' as badg;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product_dto.dart';
import 'package:marketing_surplus/app/data/model/company_type_model.dart';
import 'package:marketing_surplus/app/modules/home/controller/home_controller.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/widgets/single_item_product.dart';
import '../../../../shared/widgets/textfield_widget.dart';
import '../controller/menu_controller.dart' as con;

class MenView extends GetView<con.MenuController> {
  MenView({super.key});
  final TextEditingController _controller = TextEditingController(
    text: '',
  );
  @override
  Widget build(BuildContext context) {
    controller.getPosts();
    return Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: SizedBox(
                              height: 45,
                              child: TextField(
                                readOnly: !controller.auth.isAuth(),
                                controller: _controller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.purple),
                                  ),
                                  hintText: "search-title".tr,
                                  prefixIcon: const Icon(Icons.search),
                                  prefixIconColor: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                    BorderSide(color: Colors.purple.shade200)),
                            child: Padding(
                              padding: const EdgeInsets.all(11),
                              child: InkWell(
                                onTap: () {
                                  Overlayment.show(OverDialog(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'sort-title'.tr,
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.purple.shade200),
                                          ),
                                        ),
                                        Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text('typ-title'.tr),
                                              ),
                                              Obx(() => SizedBox(
                                                    width: Get.width - 100,
                                                    height: 100,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Wrap(
                                                          children:
                                                              controller
                                                                  .companyTypes
                                                                  .map(
                                                                    (element) =>
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child: TextButton(
                                                                          style: TextButton.styleFrom(
                                                                            backgroundColor: controller.companyTypeSearch.value != element
                                                                                ? Colors.white
                                                                                : Colors.purple.shade200,
                                                                          ),
                                                                          onPressed: () {
                                                                            if (controller.companyTypeSearch.value ==
                                                                                element) {
                                                                              controller.companies.assignAll(controller.homeController.companies);
                                                                              controller.companyTypeSearch.value = CompanyTypeModel();
                                                                            } else {
                                                                              controller.companies.assignAll(controller.homeController.companies);
                                                                              controller.companyTypeSearch.value = element;
                                                                              var data = controller.companies.toList();
                                                                              controller.companies.clear();

                                                                              controller.companies.assignAll(data.where((e) => e.type!.id == element.id).toList());
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            element.type ??
                                                                                '',
                                                                            style:
                                                                                TextStyle(color: controller.companyTypeSearch.value == element ? Colors.white : Colors.purple.shade200),
                                                                          )),
                                                                    ),
                                                                  )
                                                                  .toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text('comp-title'.tr),
                                              ),
                                              Obx(() => SizedBox(
                                                    width: Get.width - 110,
                                                    height: 300,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Wrap(
                                                          children:
                                                              controller
                                                                  .companies
                                                                  .map(
                                                                    (element) =>
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child: TextButton(
                                                                          style: TextButton.styleFrom(
                                                                            backgroundColor: controller.companySearch.value != element
                                                                                ? Colors.white
                                                                                : Colors.purple.shade200,
                                                                          ),
                                                                          onPressed: () {
                                                                            if (controller.companySearch.value ==
                                                                                element) {
                                                                              controller.companySearch.value = CompanyProductDto();
                                                                            } else {
                                                                              controller.companySearch.value = element;
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            element.companyProduct!.company!.name ??
                                                                                '',
                                                                            style:
                                                                                TextStyle(color: controller.companySearch.value == element ? Colors.white : Colors.purple.shade200),
                                                                          )),
                                                                    ),
                                                                  )
                                                                  .toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  controller.filter();
                                                },
                                                child: Text('filt-title'.tr)),
                                            TextButton(
                                                onPressed: () {
                                                  controller.companyTypeSearch
                                                          .value =
                                                      CompanyTypeModel();
                                                  controller
                                                          .companySearch.value =
                                                      CompanyProductDto();
                                                  controller.companies
                                                      .assignAll(controller
                                                          .homeController
                                                          .companies);
                                                  controller.listPosts
                                                      .assignAll(controller
                                                          .homeController
                                                          .listPosts);
                                                  Overlayment.dismissLast();
                                                },
                                                child: Text('clear-title'.tr)),
                                          ],
                                        )
                                      ],
                                    ),
                                  )));
                                },
                                child: Icon(
                                  Icons.segment_rounded,
                                  color: Colors.purple.shade200,
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           const Text('Sort by:'),
                    //           const SizedBox(
                    //             width: 10,
                    //           ),
                    //           SizedBox(
                    //             width: 110,
                    //             child: DropdownButton<String>(
                    //               iconEnabledColor: Colors.purple,
                    //               items: <String>['Hello Here', 'B', 'C', 'D']
                    //                   .map((String value) {
                    //                 return DropdownMenuItem<String>(
                    //                   value: value,
                    //                   child: Text(
                    //                     value,
                    //                     style: const TextStyle(color: Colors.purple),
                    //                   ),
                    //                 );
                    //               }).toList(),
                    //               onChanged: (_) {},
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       Row(
                    //         children: [
                    //           const Text('Sold Out'),
                    //           const SizedBox(
                    //             width: 5,
                    //           ),
                    //           CupertinoSwitch(
                    //             value: true,
                    //             activeColor: Colors.purple.shade200,
                    //             onChanged: (value) {},
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: Obx(() => !controller.isEmptyData.value
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 150,
                              color: Colors.purple.shade200,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'nosor-title'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                  color: Colors.purple.shade200),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'try-title'.tr,
                            ),
                            Text(
                              'yoursid-title'.tr,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple.shade200,
                                    shape: const StadiumBorder()),
                                child: SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      'chose-title'.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )
                    : Obx(
                        () => SingleChildScrollView(
                          child: Column(
                            children:
                                controller.auth.getTypeEnum() == Auth.comapny
                                    ? controller.products
                                        .map((element) => SingleItem(
                                                element, true, () {}, () async {
                                              controller.newProduct.value =
                                                  element.product!;
                                              await showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (builder) =>
                                                          SingleChildScrollView(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .stretch,
                                                              children: [
                                                                Container(
                                                                  color: Colors
                                                                      .purple
                                                                      .shade200,
                                                                  child:
                                                                      const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      'Edit Product',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SingleChildScrollView(
                                                                  child: Column(
                                                                    children: [
                                                                      TextFieldWidget(
                                                                        label: controller.newProduct.value.name ??
                                                                            'Name Product',
                                                                        onChanged:
                                                                            (value) {
                                                                          controller
                                                                              .newProduct
                                                                              .value
                                                                              .name = value;
                                                                        },
                                                                        textInputType:
                                                                            TextInputType.text,
                                                                      ),
                                                                      TextFieldWidget(
                                                                        label: controller.newProduct.value.descripation ??
                                                                            'Descripation Product',
                                                                        onChanged:
                                                                            (value) {
                                                                          controller
                                                                              .newProduct
                                                                              .value
                                                                              .descripation = value;
                                                                        },
                                                                        textInputType:
                                                                            TextInputType.text,
                                                                      ),
                                                                      TextFieldWidget(
                                                                        label: controller.newProduct.value.oldPrice !=
                                                                                null
                                                                            ? controller.newProduct.value.oldPrice.toString()
                                                                            : 'Old Price Product',
                                                                        onChanged:
                                                                            (value) {
                                                                          controller
                                                                              .newProduct
                                                                              .value
                                                                              .oldPrice = double.tryParse(value);
                                                                        },
                                                                        textInputType:
                                                                            TextInputType.text,
                                                                      ),
                                                                      TextFieldWidget(
                                                                        label: controller.newProduct.value.newPrice !=
                                                                                null
                                                                            ? controller.newProduct.value.newPrice.toString()
                                                                            : 'offer Price Product',
                                                                        onChanged:
                                                                            (value) {
                                                                          controller
                                                                              .newProduct
                                                                              .value
                                                                              .newPrice = double.tryParse(value);
                                                                        },
                                                                        textInputType:
                                                                            TextInputType.text,
                                                                      ),
                                                                      TextFieldWidget(
                                                                        label:
                                                                            'Amount  this  Product',
                                                                        onChanged:
                                                                            (value) {
                                                                          controller
                                                                              .amount
                                                                              .value = int.parse(value);
                                                                        },
                                                                        textInputType:
                                                                            TextInputType.text,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              'Create Date Product',
                                                                              style: TextStyle(fontSize: 18),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 120,
                                                                              child: CupertinoDatePicker(
                                                                                mode: CupertinoDatePickerMode.date,
                                                                                initialDateTime: controller.newProduct.value.dateTime ?? DateTime.now(),
                                                                                onDateTimeChanged: (DateTime newDateTime) {
                                                                                  controller.newProduct.value.dateTime = newDateTime;
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              'Expiration Date Product',
                                                                              style: TextStyle(fontSize: 18),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 120,
                                                                              child: CupertinoDatePicker(
                                                                                mode: CupertinoDatePickerMode.date,
                                                                                initialDateTime: controller.newProduct.value.expiration ?? DateTime.now(),
                                                                                onDateTimeChanged: (newDateTime) {
                                                                                  controller.newProduct.value.expiration = newDateTime;
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: FloatingActionButton.extended(
                                                                            backgroundColor: Colors.purple.shade200,
                                                                            isExtended: true,
                                                                            onPressed: () async {
                                                                              final rsult = await controller.addProduct();
                                                                              if (rsult) {
                                                                                Navigator.of(context).pop();
                                                                              }
                                                                            },
                                                                            label: SizedBox(
                                                                                width: Get.width / 3,
                                                                                child: const Center(
                                                                                    child: Text(
                                                                                  'Add',
                                                                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                                                                )))),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ));
                                            }, () {
                                              Overlayment.show(OverDialog(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          Text('Are you sure'),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {},
                                                            child: Text("yes")),
                                                        TextButton(
                                                            onPressed: () {
                                                              Overlayment
                                                                  .dismissLast();
                                                            },
                                                            child: Text("no")),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )));
                                            }, !controller.auth.isAuth()))
                                        .toList()
                                    : controller.listPosts
                                        .map((element) => SingleItem(
                                                element.companyProduct!, false,
                                                () {
                                              controller.addToBasket(
                                                  element.companyProduct!);
                                            }, () {}, () {},
                                                !controller.auth.isAuth(),
                                                type: element.type!.type!))
                                        .toList(),
                          ),
                        ),
                      )),
              ),
              const SizedBox()
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: controller.auth.getTypeEnum() == Auth.comapny
          ? FloatingActionButton(
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextFieldWidget(
                                      label: 'namepro-title'.tr,
                                      onChanged: (value) {
                                        controller.newProduct.value.name =
                                            value;
                                      },
                                      textInputType: TextInputType.text,
                                    ),
                                    TextFieldWidget(
                                      label: 'despro-title'.tr,
                                      onChanged: (value) {
                                        controller.newProduct.value
                                            .descripation = value;
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
                                        controller.amount.value =
                                            int.parse(value);
                                      },
                                      textInputType: TextInputType.text,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'creatda-title'.tr,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            height: 120,
                                            child: CupertinoDatePicker(
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              initialDateTime:
                                                  DateTime(1969, 1, 1),
                                              onDateTimeChanged:
                                                  (DateTime newDateTime) {
                                                controller.newProduct.value
                                                    .dateTime = newDateTime;
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
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            height: 120,
                                            child: CupertinoDatePicker(
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              initialDateTime:
                                                  DateTime(1969, 1, 1),
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
                                          backgroundColor:
                                              Colors.purple.shade200,
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
            )
          : controller.auth.getTypeEnum() == Auth.user
              ? FloatingActionButton(
                  tooltip: "bas-title".tr,
                  onPressed: () async {
                    controller.count.value = await controller.getCount();
                    Get.find<HomeController>().pageIndex.value = 2;
                  },
                  child: badg.Badge(
                    badgeContent: Obx(() => Text(controller.count.toString())),
                    badgeStyle:
                        badg.BadgeStyle(badgeColor: Colors.purple.shade200),
                    child: const Icon(
                      Icons.shopping_cart,
                      size: 25,
                    ),
                  ))
              : null,
    );
  }
}
