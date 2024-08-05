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

import '../../../../shared/service/notification_service.dart';
import '../../../../shared/widgets/empty_screen.dart';
import '../../../../shared/widgets/single_item_product.dart';
import '../../../data/model/company_product.dart';
import '../../../data/model/notification_charity.dart';
import '../../../data/model/order_type.dart';
import '../../admin/data/charity_repo.dart';

class CharityController extends GetxController {
  final auth = Get.find<AuthService>();
  final allDonationCompany = <Donation>[].obs;
  final product = <ProductDonation>[].obs;
  final allCharity = <Charity>[].obs;
  final orderTypes = <OrderType>[].obs;
  final lastOrderCharity = <Donation>[].obs;
  final lastOrderCharityJustCharity = <Donation>[].obs;
  final products = <CompanyProduct>[].obs;
  final toPayProduct = <CompanyProduct>[].obs;
  final isLoading = false.obs;
  final notAccept = ''.obs;
  final isProcces = false.obs;
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

  Future<void> updateDonation(int id, bool status, bool isCencal,
      bool isCompany, String type, Charity charity, int proId) async {
    var result = await OrderService()
        .updateStatusDonation(id, status, isCencal, isCompany, notAccept.value);
    if (result) {
      if (status && !isCencal) {
        var notif = NotificationCharity(
            createdAt: DateTime.now(),
            type: 'Company Accept',
            isRead: false,
            message:
                'Company Accept $type for Charity: id${charity.id} name${charity.name}',
            productDonationId: proId);
        await NotificationService().addNotificationCahrity(notif);
      } else if (!status && isCencal) {
        print('Hello for cancel');
        var notif = NotificationCharity(
            createdAt: DateTime.now(),
            type: 'Company Not Accept',
            isRead: false,
            message:
                'Company Not Accept $type for Charity: id${charity.id} name${charity.name} for ${notAccept.value}',
            productDonationId: proId);
        await NotificationService().addNotificationCahrity(notif);
      }
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
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.purple.shade200)),
                            onPressed: () {
                              Overlayment.dismissLast();
                            },
                            icon: Icon(Icons.arrow_back)),
                      ),
                    ),
                    Obx(() => toPayProduct.isEmpty
                        ? SizedBox.shrink()
                        : isProcces.value
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.purple.shade200)),
                                      onPressed: () async {
                                        await saveOrderDonation(charity);
                                        Overlayment.dismissLast();
                                      },
                                      child: Text('Donation')),
                                ),
                              )
                            : SizedBox.shrink()),
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
    Charity charityId,
  ) async {
    isProcces.value = true;
    var productDonation = <ProductDonation>[];
    var donation = Donation(
      charityId: charityId.id,
      createdAt: DateTime.now(),
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
    var result = await OrderService().saveDonation(donation, productDonation);
    isProcces.value = false;
    for (var element in result) {
      var notif = NotificationCharity(
          createdAt: DateTime.now(),
          type: 'Company Create Donation',
          isRead: false,
          message:
              'Company Create Donation for Charity: id${charityId.id!} name${charityId.name} ',
          productDonationId: element);
      await NotificationService().addNotificationCahrity(notif);
    }
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
    product.clear();
    var data = await OrderService().getAllDonation(idCh: id);
    for (var element in data) {
      print('999999999999999999 ${element.id}');
    }
    var items =
        data.where((p0) => p0.companyProduct!.company!.id! == getCompanyId());
    for (var element in items) {
      print('888888888888888888888 ${element.id}');
    }
    product.assignAll(items);
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
    for (var e in result) {
      if (!lastOrderCharityJustCharity
          .any((element) => element.charity!.id == e.charity!.id)) {
        lastOrderCharityJustCharity.add(e);
      }
    }
    print(
        '-------------------getAllDonationForCompany with ${result.length}--------------------');
    isLoading.value = false;
  }

  Future<void> getOrderType() async {
    final result = await OrderService().getOrderType();
    orderTypes.assignAll(result);
  }
}
