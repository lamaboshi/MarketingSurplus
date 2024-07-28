import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/charity.dart';
import 'package:marketing_surplus/app/data/model/company.dart';
import 'package:marketing_surplus/app/data/model/donation.dart';
import 'package:marketing_surplus/app/data/model/product_donation.dart';
import 'package:marketing_surplus/app/modules/admin/data/company_repo.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';
import 'package:marketing_surplus/shared/service/order_service.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/widgets/empty_screen.dart';
import '../../../../shared/widgets/single_item_product.dart';
import '../../../data/model/company_product.dart';
import '../../../data/model/order_type.dart';
import '../../admin/data/charity_repo.dart';

class CharityController extends GetxController {
  final auth = Get.find<AuthService>();
  final allDonationCompany = <Donation>[].obs;
  final product = <ProductDonation>[].obs;
  final allCharity = <Charity>[].obs;
  final orderTypes = <OrderType>[].obs;
  final lastOrderCharity = <Donation>[].obs;
  final products = <CompanyProduct>[].obs;
  final toPayProduct = <CompanyProduct>[].obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  int getCompanyId() {
    if (auth.getTypeEnum() == Auth.comapny) {
      var id = (auth.getDataFromStorage() as Company).id!;
      return id;
    }
    return 0;
  }

  Future<void> getData() async {
    if (auth.getTypeEnum() == Auth.comapny) {
      await getAllDonationForCompany();
      await getCharities();
      await getOrderType();
      await getLastOrderCharity();
    }
  }

  Future<void> updateDonation(
      int id, bool status, bool isCencal, bool isCompany) async {
    var result = await OrderService()
        .updateStatusDonation(id, status, isCencal, isCompany);
    if (result) {
      Overlayment.dismissAll();
      getData();
    }
  }

  Future<void> getAllProduct(int companyId) async {
    final data = await CompanyRepository().getAllCompanyProduct(companyId);
    products.assignAll(data);
    print(products.length);
  }

  Future<void> saveCharityForDonatin(Charity charity) async {
    var id = (auth.getDataFromStorage() as Company).id;
    getAllProduct(id!);
    Overlayment.show(OverDialog(
        child: Obx(() => products.isEmpty
            ? EmptyData()
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => toPayProduct.isEmpty
                        ? SizedBox.shrink()
                        : Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await saveOrderDonation(charity.id!);
                                    Overlayment.dismissLast();
                                  },
                                  child: Text('Donation')),
                            ),
                          )),
                    Obx(() => Column(
                        children: toPayProduct
                            .map((element) => Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(element.product!.name ?? ""),
                                      Text(element.amountApp.toString()),
                                      InkWell(
                                          onTap: () {
                                            toPayProduct.remove(element);
                                            toPayProduct.refresh();
                                          },
                                          child: Icon(Icons.delete))
                                    ],
                                  ),
                                ))
                            .toList())),
                    Column(
                        children: products
                            .map((element) => SingleItem(element, false, () {
                                  if (element.amount != 0) {
                                    if (!toPayProduct
                                        .any((e) => e.id == element.id)) {
                                      toPayProduct.add(element);
                                    } else {
                                      var item = toPayProduct
                                          .where((e) => e.id == element.id)
                                          .first;
                                      if ((item.amountApp! + 1) <=
                                          item.amount!) {
                                        item.amountApp = item.amountApp! + 1;
                                        toPayProduct.refresh();
                                      }
                                    }
                                  }
                                }, () async {}, () {}, !auth.isAuth()))
                            .toList()),
                  ],
                ),
              ))));
  }

  Future<void> saveOrderDonation(
    int charityId,
  ) async {
    var productDonation = <ProductDonation>[];
    var donation = Donation(
      charityId: charityId,
      orderTypeId: 2,
    );
    for (var element in toPayProduct) {
      var value = element.product!.newPrice! * element.amountApp!;
      var total = value.toInt();
      productDonation.add(ProductDonation(
          isCompany: true,
          companyProductId: element.id,
          amount: element.amountApp,
          totalPrice: total));
    }
    await OrderService().saveDonation(donation, productDonation);
    toPayProduct.clear();
  }

  Future<void> getAllDonationForCompany() async {
    isLoading.value = true;
    var id = (auth.getDataFromStorage() as Company).id!;
    final data = await OrderService().getAllDonationForCompany(id);
    for (var e in data) {
      if (!allDonationCompany
          .any((element) => element.charity!.id == e.charity!.id!)) {
        allDonationCompany.add(e);
      }
    }

    print(
        '-------------------getAllDonationForCompany with ${data.length}--------------------');
    isLoading.value = false;
  }

  Future<void> getAllDonation(int id) async {
    var data = await OrderService().getAllDonation(idCh: id);
    product.assignAll(data);
  }

  Future<void> getCharities() async {
    isLoading.value = true;
    final data = await CharityRepository().getCharities();
    allCharity.assignAll(data);
    print(
        '-------------------getCharities with ${data.length}--------------------');
    isLoading.value = false;
  }

  Future<void> getLastOrderCharity() async {
    isLoading.value = true;
    var id = (auth.getDataFromStorage() as Company).id!;
    final result = await OrderService().getAllDonationForCompany(id);

    lastOrderCharity.assignAll(result);
    print(
        '-------------------getAllDonationForCompany with ${result.length}--------------------');
    isLoading.value = false;
  }

  Future<void> getOrderType() async {
    final result = await OrderService().getOrderType();
    orderTypes.assignAll(result);
  }
}
