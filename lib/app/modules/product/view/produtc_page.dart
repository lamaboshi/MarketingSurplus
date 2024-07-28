import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/product/controller/product_controller.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/util.dart';
import '../../../../shared/widgets/textfield_widget.dart';
import '../../../data/model/company_product.dart';

class ProductView extends GetView<ProductController> {
  ProductView({this.product, this.onTap});
  final CompanyProduct? product;
  final VoidCallback? onTap;
  Widget headerBuild(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          //===================back
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade100,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1))
                  ],
                  borderRadius: BorderRadius.circular(
                      15)), //بدنا نروع ع الكونتينير تبعيت البرودكت ونحطو ب ويدجت ونضيف الصورة الي مصورتا
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.purple.shade200,
                  ),
                  onPressed: () {
                    Overlayment.dismissLast();
                  })),
          const Expanded(child: Text("")),
        ],
      ),
    );
  }

  Widget imageProduct() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade100,
                spreadRadius: 1,
                blurRadius: 0,
                offset: const Offset(0, 1))
          ],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(
                  50.0)) //بدنا نروع ع الكونتينير تبعيت البرودكت ونحطو ب ويدجت ونضيف الصورة الي مصورتا
          ),
      child: Column(
        children: <Widget>[
          Utility.getImage(
              base64StringPh: product!.product!.image,
              link: product!.product!.onlineImage,
              hight: Get.height / 2,
              width: Get.width),
          const Padding(padding: EdgeInsets.only(top: 30.0)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              imageProduct(),
              Container(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product!.product!.name ?? '',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Get.find<AuthService>().getTypeEnum() == Auth.comapny
                            ? Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.newProduct.value =
                                            product!.product!;

                                        Overlayment.show(OverDialog(
                                            height: Get.height / 1.3,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Container(
                                                    color:
                                                        Colors.purple.shade200,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'editpro-title'.tr,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await controller
                                                          .pickImageFun();
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Obx(() => controller
                                                                .stringPickImage
                                                                .value
                                                                .isNotEmpty
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              33),
                                                                  child: Utility.imageFromBase64String(
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
                                                        Center(
                                                            child: Text(
                                                                'Addanimage'
                                                                    .tr)),
                                                      ],
                                                    ),
                                                  ),
                                                  Form(
                                                    key: controller.keyForm,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Column(
                                                          children: [
                                                            TextFieldWidget(
                                                              label: controller
                                                                      .newProduct
                                                                      .value
                                                                      .name ??
                                                                  'namepro-title'
                                                                      .tr,
                                                              validator:
                                                                  controller
                                                                      .forceValue,
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .newProduct
                                                                    .value
                                                                    .name = value;
                                                              },
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                            ),
                                                            TextFieldWidget(
                                                              validator:
                                                                  controller
                                                                      .forceValue,
                                                              label: controller
                                                                      .newProduct
                                                                      .value
                                                                      .descripation ??
                                                                  'despro-title'
                                                                      .tr,
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .newProduct
                                                                    .value
                                                                    .descripation = value;
                                                              },
                                                              textInputType:
                                                                  TextInputType
                                                                      .text,
                                                            ),
                                                            TextFieldWidget(
                                                              validator:
                                                                  controller
                                                                      .forceValue,
                                                              label: controller
                                                                          .newProduct
                                                                          .value
                                                                          .oldPrice !=
                                                                      null
                                                                  ? controller
                                                                      .newProduct
                                                                      .value
                                                                      .oldPrice
                                                                      .toString()
                                                                  : 'oldpri-title'
                                                                      .tr,
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                        .newProduct
                                                                        .value
                                                                        .newPrice =
                                                                    double.tryParse(
                                                                        value);
                                                              },
                                                              textInputType:
                                                                  TextInputType
                                                                      .number,
                                                            ),
                                                            TextFieldWidget(
                                                              validator:
                                                                  controller
                                                                      .forceValue,
                                                              label: controller
                                                                          .newProduct
                                                                          .value
                                                                          .newPrice !=
                                                                      null
                                                                  ? controller
                                                                      .newProduct
                                                                      .value
                                                                      .newPrice
                                                                      .toString()
                                                                  : 'offerpri-title'
                                                                      .tr,
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                        .newProduct
                                                                        .value
                                                                        .newPrice =
                                                                    double.tryParse(
                                                                        value);
                                                              },
                                                              textInputType:
                                                                  TextInputType
                                                                      .number,
                                                            ),
                                                            TextFieldWidget(
                                                              validator:
                                                                  controller
                                                                      .forceValue,
                                                              label:
                                                                  'amoutth-title'
                                                                      .tr,
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                        .amount
                                                                        .value =
                                                                    int.parse(
                                                                        value);
                                                              },
                                                              textInputType:
                                                                  TextInputType
                                                                      .number,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'creatda-title'
                                                                        .tr,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 120,
                                                                    child:
                                                                        CupertinoDatePicker(
                                                                      minimumYear:
                                                                          2022,
                                                                      maximumYear:
                                                                          2026,
                                                                      mode: CupertinoDatePickerMode
                                                                          .date,
                                                                      initialDateTime:
                                                                          DateTime
                                                                              .now(),
                                                                      onDateTimeChanged:
                                                                          (DateTime
                                                                              newDateTime) {
                                                                        controller
                                                                            .newProduct
                                                                            .value
                                                                            .dateTime = newDateTime;
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'expda-title'
                                                                        .tr,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 120,
                                                                    child:
                                                                        CupertinoDatePicker(
                                                                      minimumYear:
                                                                          2022,
                                                                      maximumYear:
                                                                          2026,
                                                                      mode: CupertinoDatePickerMode
                                                                          .date,
                                                                      initialDateTime:
                                                                          DateTime
                                                                              .now(),
                                                                      onDateTimeChanged:
                                                                          (newDateTime) {
                                                                        controller
                                                                            .newProduct
                                                                            .value
                                                                            .expiration = newDateTime;
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: FloatingActionButton
                                                                  .extended(
                                                                      backgroundColor: Colors
                                                                          .purple
                                                                          .shade200,
                                                                      isExtended:
                                                                          true,
                                                                      onPressed:
                                                                          () async {
                                                                        if (controller
                                                                            .keyForm
                                                                            .currentState!
                                                                            .validate()) {
                                                                          final rsult =
                                                                              await controller.updateProduct();
                                                                          Overlayment
                                                                              .dismissLast();
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
                                                                            style:
                                                                                const TextStyle(fontSize: 18, color: Colors.white),
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
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Overlayment.show(OverDialog(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text('Are you sure'),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      await controller
                                                          .deleteProduct(
                                                              product!.product!
                                                                  .id!);
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
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 15.0)),
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Flexible(
                              child: Text(
                            product!.product!.descripation ?? '',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.grey),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if (product!.company != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('cmp-name'.tr),
                      Chip(
                          side: BorderSide(color: Colors.orange.shade300),
                          backgroundColor: Colors.green.shade400,
                          labelPadding: const EdgeInsets.all(2),
                          label: Text(
                            product!.company!.name ?? '',
                            style: const TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('all-amount'.tr),
                    Chip(
                        side: BorderSide(color: Colors.green.shade400),
                        backgroundColor: Colors.green.shade400,
                        labelPadding: const EdgeInsets.all(2),
                        label: Text(
                          product!.amount != null
                              ? product!.amount.toString()
                              : '0',
                          style: const TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('p-offer'.tr),
                    Chip(
                        side: BorderSide(color: Colors.red.shade400),
                        backgroundColor: Colors.red.shade400,
                        labelPadding: const EdgeInsets.all(2),
                        label: Text(
                          '${getPercentage(product!.product!.oldPrice!, product!.product!.newPrice!).toStringAsFixed(2)}%',
                          style: const TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
              product!.product!.isExpiration!
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('is-ex'.tr),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              color: Colors.orange,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Expired'.tr,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('creatda-title'.tr),
                    Text(
                      product!.product!.dateTime == null
                          ? ''
                          : product!.product!.dateTime.toString(),
                      style: TextStyle(color: Colors.purple.shade200),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('expda-title'.tr),
                    Text(
                      product!.product!.expiration == null
                          ? ''
                          : product!.product!.expiration.toString(),
                      style: TextStyle(color: Colors.purple.shade200),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            height: 120,
            child: headerBuild(context),
          )
        ],
      ),
      bottomNavigationBar: Get.find<AuthService>().getTypeEnum() == Auth.comapny
          ? InkWell(
              onTap: () {
                onTap!();
                Overlayment.dismissLast();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 50, right: 30),
                  height: 75.0,
                  decoration: BoxDecoration(
                      //  color: Colors.red[300],
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.purple.shade100,
                            Colors.purple.shade200,
                            Colors.purple.shade300,
                            Colors.purple.shade400,
                          ]),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade100,
                            spreadRadius: 7,
                            blurRadius: 4,
                            offset: const Offset(0, 3))
                      ],
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.money,
                                color: Colors.purple,
                              ),
                              Text(
                                product!.product!.newPrice == null
                                    ? ''
                                    : ' ${product!.product!.newPrice!}',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.money,
                                color: Colors.grey.shade800,
                              ),
                              Text(
                                product!.product!.oldPrice == null
                                    ? ''
                                    : ' ${product!.product!.oldPrice!}',
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 17,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))
          : InkWell(
              onTap: () {
                onTap!();
                Overlayment.dismissLast();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 50, right: 30),
                  height: 75.0,
                  decoration: BoxDecoration(
                      //  color: Colors.red[300],
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.purple.shade100,
                            Colors.purple.shade200,
                            Colors.purple.shade300,
                            Colors.purple.shade400,
                          ]),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade100,
                            spreadRadius: 7,
                            blurRadius: 4,
                            offset: const Offset(0, 3))
                      ],
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.money),
                              Text(
                                product!.product!.newPrice == null
                                    ? ''
                                    : ' ${product!.product!.newPrice!}',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.money),
                              Text(
                                product!.product!.oldPrice == null
                                    ? ''
                                    : ' ${product!.product!.oldPrice!}',
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 17,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("addd-title".tr,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  double getPercentage(double p1, double p2) => 100 - ((p2 * 100) / p1);
}
