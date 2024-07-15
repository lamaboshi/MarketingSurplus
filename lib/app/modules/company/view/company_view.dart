import 'package:badges/badges.dart' as badg;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/home/controller/home_controller.dart';
import 'package:marketing_surplus/app/routes/app_routes.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../../shared/service/util.dart';
import '../../../../shared/widgets/single_item_product.dart';
import '../../../../shared/widgets/textfield_widget.dart';
import '../../../data/model/rate.dart';
import '../controller/company_controller.dart';

class CompanyView extends GetView<CompanyController> {
  const CompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.purple.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(40))),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'clout-title'.tr,
              style: TextStyle(
                  color: Colors.purple.shade200,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: Get.height / 3.2,
            width: Get.width,
            child: Utility.getImage(
                base64StringPh:
                    controller.dto.value.companyProduct!.company!.image,
                link:
                    controller.dto.value.companyProduct!.company!.onlineImage),
          ),
          Container(
            height: Get.height / 3.2,
            width: Get.width,
            color: Colors.purple.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 65, left: 8, right: 8),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      controller.companyName.value,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21),
                    ),
                    controller.dto.value.companyProduct!.rateNumber != null
                        ? Row(
                            children: Iterable<int>.generate(5)
                                .toList()
                                .map((e) => Icon(
                                      Icons.star,
                                      color: controller.dto.value
                                                  .companyProduct!.rateNumber! <
                                              6
                                          ? e + 1 <=
                                                  controller
                                                      .dto
                                                      .value
                                                      .companyProduct!
                                                      .rateNumber!
                                              ? Colors.amber
                                              : Colors.grey
                                          : Colors.amber,
                                    ))
                                .toList(),
                          )
                        : RatingBar.builder(
                            initialRating: controller.rate.value,
                            itemSize: 22,
                            minRating: 0,
                            direction: Axis.horizontal,
                            unratedColor: Colors.black,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              Overlayment.show(OverDialog(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Rate to ${controller.companyName.value}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: controller.rate.value,
                                    itemSize: 22,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    unratedColor: Colors.black,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                      controller.rate.value = rating;
                                    },
                                  ),
                                  TextFieldWidget(
                                    onChanged: (value) {
                                      controller.rateDes.value = value;
                                    },
                                    textInputType: TextInputType.emailAddress,
                                    label: 'Description'.tr,
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        await controller.addRate(
                                            Rate(
                                                rateNumber: controller
                                                    .rate.value
                                                    .toInt(),
                                                description:
                                                    controller.rateDes.value),
                                            controller
                                                .dto.value.subscription!.id!);
                                        Overlayment.dismissLast();
                                      },
                                      child: Chip(
                                          backgroundColor:
                                              Colors.purple.shade200,
                                          label: const Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                ],
                              )));
                            },
                          )
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: SizedBox(
                  height: Get.height / 4,
                  width: Get.width,
                ),
              ),
              Flexible(
                flex: 2,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(25),
                          right: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.dto.value.companyProduct!
                                              .company!.name ??
                                          '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                          color: Colors.purple.shade300),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Row(
                                        children: [
                                          Flexible(
                                              child: Text(controller
                                                      .dto
                                                      .value
                                                      .companyProduct!
                                                      .company!
                                                      .description ??
                                                  ''))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'itemcomp-title'.tr,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.purple.shade200),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Obx(() => controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : controller.products.isEmpty
                                  ? Text('nodat-title'.tr)
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: controller.products
                                            .map((element) =>
                                                SingleItem(element, false, () {
                                                  controller
                                                      .addToBasket(element);
                                                }, () {}, () {},
                                                    !controller.auth.isAuth()))
                                            .toList(),
                                      ),
                                    )),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Obx(
            () => controller.dto.value.subscription == null &&
                    controller.auth.getTypeEnum() == Auth.user
                ? Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () async {
                        final companyId =
                            controller.dto.value.companyProduct!.companyId;
                        await controller.addSubscription(companyId!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                            backgroundColor: Colors.white,
                            label: Text(
                              'subscription-title'.tr,
                              style: TextStyle(
                                color: Colors.purple.shade200,
                              ),
                            )),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          tooltip: 'basket-title'.tr,
          onPressed: () async {
            controller.count.value = await controller.getCount();
            Get.find<HomeController>().pageIndex.value = 2;
            Get.rootDelegate.offNamed(Paths.HOME);
          },
          child: badg.Badge(
            badgeContent: Obx(() => Text(controller.count.toString())),
            badgeStyle: badg.BadgeStyle(badgeColor: Colors.purple.shade200),
            child: const Icon(
              Icons.shopping_cart,
              size: 25,
            ),
          )),
    );
  }
}
