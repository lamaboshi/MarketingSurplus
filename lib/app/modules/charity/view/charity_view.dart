import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/charity.dart';
import 'package:marketing_surplus/app/data/model/donation.dart';

import 'package:marketing_surplus/app/modules/charity/controller/charity_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/util.dart';
import '../../../../shared/widgets/auth_bottom_sheet.dart';
import '../../../../shared/widgets/empty_screen.dart';
import '../../../../shared/widgets/section_widget.dart';

import 'charity_details.dart';
import 'charity_order.dart';

class CharityView extends GetView<CharityController> {
  const CharityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      controller.onInit();
                    },
                    icon: Icon(Icons.refresh)),
              ),
              SectionWidget(
                  flex: 1,
                  icon: Icons.local_fire_department_rounded,
                  title: 'Features'.tr,
                  child: Row(children: [
                    CharityOrder(),
                    Expanded(
                      child: getMinCard(
                          Icons.home_work_rounded, 'all-donation-company'.tr,
                          onTab: () {
                        Overlayment.show(OverDialog(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => controller.allDonationCompany.isEmpty
                                  ? EmptyData()
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: controller.allDonationCompany
                                            .map((element) => ListTile(
                                                  title:
                                                      Text(' # ${element.id}'),
                                                  subtitle: Column(
                                                    children: [
                                                      Text(
                                                        element.charity!.name ??
                                                            '',
                                                        style: TextStyle(
                                                            color: Colors.purple
                                                                .shade200,
                                                            fontSize: 19),
                                                      ),
                                                      Text(getType(
                                                          element.orderTypeId ??
                                                              0)),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                            )
                          ],
                        )));
                      }),
                    ),
                  ])),
              SectionWidget(
                flex: 3,
                icon: Icons.home_filled,
                title: 'allCharity'.tr,
                child: controller.allCharity.isEmpty
                    ? EmptyData()
                    : SingleChildScrollView(
                        child: Obx(
                          () => Column(
                            children: controller.allCharity
                                .map((element) => SingleCharity(
                                      charity: element,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
              )
            ],
          ));
  }

  String getType(int id) =>
      controller.orderTypes.where((p0) => p0.id == id).first.name ?? '';
}

Widget getMinCard(IconData icon, String value, {Function? onTab}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        onTab!();
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(
                icon,
                color: Colors.purple.shade200,
                size: 60,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.purple.shade200),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
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

class SingleCharity extends GetView<CharityController> {
  final Charity? charity;

  const SingleCharity({super.key, required this.charity});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!controller.auth.isAuth()) {
          await AuthBottomSheet().modalBottomSheet(context);
        } else {
          Overlayment.show(OverPanel(
              child: CharityDetails(
            charity: charity,
          )));
        }
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
                        base64StringPh: charity!.image,
                        link: charity!.onlineImage),
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
