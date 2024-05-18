import 'package:badges/badges.dart' as badg;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/shared/widgets/auth_bottom_sheet.dart';

import '../../../../shared/widgets/single_item_product.dart';
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
              'Clout',
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
            child: Image.asset(
              'assets/images/post_2.jpg',
              fit: BoxFit.fitWidth,
              width: Get.width,
            ),
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Items Company',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Obx(() => Column(
                              children: controller.products
                                  .map((element) => SingleItem(element, () {
                                        controller.addToBasket(element);
                                      }, !controller.auth.isAuth()))
                                  .toList(),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Obx(
            () => controller.dto.value.subscription == null
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
                              'Subscription',
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
          tooltip: "Basket",
          onPressed: () async {
            await AuthBottomSheet().modalBasketBottomSheet(context);
            controller.count.value = controller.getCount();
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
