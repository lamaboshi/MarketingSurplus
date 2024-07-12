import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/charity.dart';
import 'package:marketing_surplus/app/data/model/donation.dart';
import 'package:marketing_surplus/app/modules/charity/controller/charity_controller.dart';

import '../../../../shared/service/util.dart';
import '../../../../shared/widgets/empty_screen.dart';
import '../../../../shared/widgets/section_widget.dart';

class CharityView extends GetView<CharityController> {
  const CharityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              SectionWidget(
                flex: 1,
                icon: Icons.add_home_work_rounded,
                title: 'last-order-charity'.tr,
                child: controller.lastOrderCharity.isEmpty
                    ? EmptyData()
                    : Column(
                        children: controller.lastOrderCharity
                            .map((element) => Container())
                            .toList(),
                      ),
              ),
              SectionWidget(
                flex: 1,
                icon: Icons.home_work_rounded,
                title: 'all-donation-company'.tr,
                child: controller.allDonationCompany.isEmpty
                    ? EmptyData()
                    : Column(
                        children: controller.allDonationCompany
                            .map((element) => Container())
                            .toList(),
                      ),
              ),
              SectionWidget(
                flex: 1,
                icon: Icons.home_filled,
                title: 'allCharity'.tr,
                child: controller.allCharity.isEmpty
                    ? EmptyData()
                    : SingleChildScrollView(
                        child: Column(
                          children: controller.allCharity
                              .map((element) => SingleCharity(
                                    charity: element,
                                  ))
                              .toList(),
                        ),
                      ),
              )
            ],
          ));
  }
}

class SingleDonation extends GetView<CharityController> {
  final Donation? donation;
  const SingleDonation({super.key, required this.donation});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(donation!.charity!.name ?? ''),
        trailing: Text(
          donation!.pricePay != null ? donation!.pricePay.toString() : '',
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('charity-goals'.tr),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    donation!.charity!.goals ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text('order-type'.tr),
                const SizedBox(
                  width: 5,
                ),
                Chip(
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.purple.shade200,
                    label: Text(
                      controller.orderTypes
                              .where((p0) => p0.id == donation!.orderTypeId)
                              .first
                              .name ??
                          '',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SingleCharity extends GetView {
  final Charity? charity;

  const SingleCharity({super.key, required this.charity});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // if (!controller.auth.isAuth()) {
        //   await AuthBottomSheet().modalBottomSheet(context);
        // } else {
        //   await controller.saveSelectedCompany(product);
        //   if (Get.isRegistered<CompanyController>()) {
        //     Get.find<CompanyController>().onInit();
        //   }
        //   await Get.rootDelegate.toNamed(Paths.COMPANY_PAGE);
        // }
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.purpleAccent.shade100,
                    ),
                    child: Utility.getImage(
                        base64StringPh: charity!.image, link: null),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      charity!.name == null ? '' : charity!.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
