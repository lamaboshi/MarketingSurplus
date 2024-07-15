import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/product/controller/product_controller.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/util.dart';
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
                                      onTap: () {},
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                      onTap: () {},
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
          ? null
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
                          Text(
                            product!.product!.newPrice == null
                                ? ''
                                : ' ${product!.product!.newPrice!}\$',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            product!.product!.oldPrice == null
                                ? ''
                                : ' ${product!.product!.oldPrice!}\$',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 17,
                                decoration: TextDecoration.lineThrough),
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
