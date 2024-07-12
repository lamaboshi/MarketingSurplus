import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product_dto.dart';
import 'package:marketing_surplus/app/data/model/company_type_model.dart';
import 'package:marketing_surplus/app/modules/company/controller/company_controller.dart';
import 'package:marketing_surplus/app/modules/home/controller/home_controller.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../../shared/service/util.dart';
import '../../../../shared/widgets/auth_bottom_sheet.dart';
import '../../../routes/app_routes.dart';

// ignore: must_be_immutable
class MainView extends GetView<HomeController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: controller.companyTypes.isEmpty
                      ? const CircularProgressIndicator()
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: controller.companyTypes
                                  .map((element) => SingleCatrgory(
                                        type: element,
                                      ))
                                  .toList()),
                        ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Obx(
              () => SizedBox(
                child: controller.isloading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.companies.isEmpty
                        ? Text('nocomp-title'.tr)
                        : SingleChildScrollView(
                            child: Obx(
                              () => Column(
                                  children: controller.companies
                                      .map((element) => SingleCompany(
                                            product: element,
                                          ))
                                      .toList()),
                            ),
                          ),
              ),
            ),
          )
        ]));
  }
}

class SingleCompany extends GetView<HomeController> {
  final CompanyProductDto product;

  const SingleCompany({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    final companyPro = product.companyProduct;
    return InkWell(
      onTap: () async {
        if (!controller.auth.isAuth()) {
          await AuthBottomSheet().modalBottomSheet(context);
        } else {
          await controller.saveSelectedCompany(product);
          if (Get.isRegistered<CompanyController>()) {
            Get.find<CompanyController>().onInit();
          }
          await Get.rootDelegate.toNamed(Paths.COMPANY_PAGE);
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
                    height: MediaQuery.of(context).size.height / 5.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.purpleAccent.shade100,
                    ),
                    child: Utility.getImage(
                        base64StringPh: companyPro!.company!.image,
                        link: companyPro.company!.onlineImage),
                  ),
                  product.subscription == null && controller.isAll.value
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 5.5,
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        )
                      : const SizedBox.shrink(),
                  product.subscription == null &&
                          controller.isAll.value &&
                          controller.auth.getTypeEnum() == Auth.user
                      ? Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () async {
                              if (!controller.auth.isAuth()) {
                                await AuthBottomSheet()
                                    .modalBottomSheet(context);
                              } else {
                                await controller
                                    .addSubscription(companyPro.company!.id!);
                              }
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      companyPro.company!.name == null
                          ? ''
                          : companyPro.company!.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: Iterable<int>.generate(5)
                          .toList()
                          .map((e) => Icon(
                                Icons.star,
                                color: product.rateNumber == null
                                    ? Colors.grey
                                    : product.rateNumber! < 6
                                        ? e + 1 <= product.rateNumber!
                                            ? Colors.amber
                                            : Colors.grey
                                        : Colors.amber,
                              ))
                          .toList(),
                    )

                    // RatingBar.builder(
                    //   initialRating: product.rateNumber == null
                    //       ? 0.0
                    //       : product.rateNumber! < 6
                    //           ? double.parse(product.rateNumber.toString())
                    //           : 5.0,
                    //   itemSize: 22,
                    //   minRating: 0,
                    //   direction: Axis.horizontal,
                    //   itemCount: 5,
                    //   itemBuilder: (context, _) => const Icon(
                    //     Icons.star,
                    //     color: Colors.amber,
                    //   ), onRatingUpdate: (double value) {  },

                    // ),
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

class SingleCatrgory extends GetView<HomeController> {
  final CompanyTypeModel type;
  const SingleCatrgory({
    super.key,
    required this.type,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!controller.auth.isAuth()) {
          await AuthBottomSheet().modalBottomSheet(context);
        } else {
          if (controller.selectType.value == type) {
            await controller.getPosts();
            await controller.getAllCompanyType();
            controller.selectType.value = CompanyTypeModel();
          } else {
            controller.selectType.value = type;
            await controller.filterByType();
          }
        }
      },
      child: Container(
          padding: const EdgeInsets.all(5),
          child: Obx(
            () => Chip(
                side: BorderSide(
                    color: controller.selectType.value.id == type.id
                        ? Colors.white
                        : Colors.purple.shade200),
                backgroundColor: controller.selectType.value.id == type.id
                    ? Colors.purple.shade200
                    : Colors.white,
                label: Text(
                  type.type == null ? '' : type.type!,
                  style: TextStyle(
                    color: controller.selectType.value.id == type.id
                        ? Colors.white
                        : Colors.purple.shade200,
                  ),
                )),
          )),
    );
  }
}
