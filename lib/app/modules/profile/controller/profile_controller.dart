import 'dart:math';

import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';

import '../../../../shared/service/order_service.dart';
import '../../../data/model/company.dart';
import '../../../data/model/company_product.dart';
import '../../../data/model/order_type.dart';
import '../../../data/model/product.dart';
import '../../../data/model/product_donation.dart';
import '../../../data/model/save_product.dart';
import '../../admin/data/company_repo.dart';

class ProfileController extends GetxController {
  final orderProducts = <OrderProduct>[].obs;
  final lastOrderCharity = <ProductDonation>[].obs;
  final auth = Get.find<AuthService>();
  final orderTypes = <OrderType>[].obs;
  final saved = 0.0.obs;
  var rng = Random();
  final products = <CompanyProduct>[].obs;
  final newProduct = Product(
          name: 'test',
          descripation: 'Some Data',
          expiration: DateTime.now().add(const Duration(days: 2)),
          dateTime: DateTime.now(),
          oldPrice: 300,
          newPrice: 100)
      .obs;
  final amount = 0.obs;
  int randomValue() => rng.nextInt(12);
  final details = <Map>[].obs;
  final value = 0.obs;
  final banfi = [
    {'Advantage_1': 'Description_1'},
    {'Advantage_2': 'Description_2'},
    {'Advantage_3': 'Description_3'},
    {'Advantage_4': 'Description_4'},
    {'Advantage_5': 'Description_5'},
    {'Advantage_6': 'Description_6'},
    {'Advantage_7': 'Description_7'},
    {'Advantage_8': 'Description_8'},
    {'Advantage_9': 'Description_9'},
    {'Advantage_10': 'Description_10'},
    {'Advantage_11': 'Description_11'},
    {'Advantage_12': 'Description_12'},
  ];
  @override
  void onInit() {
    getData();
    getsaveOrder();
    value.value = randomValue();
    super.onInit();
  }

  Future<void> getData() async {
    final billsController = Get.find<BillsController>();
    await billsController.getData();

    orderProducts.assignAll(billsController.orderProducts);
    lastOrderCharity.assignAll(billsController.lastOrderCharity);
    print(
        '----------------getLastOrderCharity from profail with ${lastOrderCharity.length}-----------');
    await billsController.getOrderType();
    orderTypes.assignAll(billsController.orderTypes);

    if (auth.getTypeEnum() == Auth.comapny) {
      var id = (auth.getDataFromStorage() as Company).id;
      await getAllProduct(id!);
    }
  }

  Future<void> getAllProduct(int companyId) async {
    final data = await CompanyRepository().getAllCompanyProduct(companyId);

    for (var element in data) {
      var date = element.product!.expiration!.difference(DateTime.now());
      if (date.inDays <= 5) {
        products.assign(element);
      }
      // var exparItems = data
      //     .where((element) => element.product!.isExpiration == true)
      //     .toList();
      // products.assignAll(exparItems);
    }
  }

  Future<void> getsaveOrder() async {
    saved.value = 0.0;
    details.clear();
    if (auth.getTypeEnum() == Auth.comapny) {
      final data = await OrderService().getOrderDetailsForCompany();
      print(
          '--------------------------------getOrderDetailsForCompany with ${data.length}------------------');

      final last = data
          .where((element) => element.bills!.last.orderStatusId == 4)
          .toList();
      for (var element in last) {
        details.add(
            {(element.amount! * element.totalPrice!): element.totalPrice!});
        saved.value = saved.value + element.totalPrice!;
      }
    } else {
      for (var element in orderProducts) {
        var old = element.companyProduct!.product!.oldPrice! *
            orderProducts.last.amount!;

        final newValue = (old - element.totalPrice!);
        print('-------------------------${newValue}');
        details.add({old: element.totalPrice!});
        saved.value = saved.value + newValue;
      }
      print('-------------------------${saved.value}');
    }
  }

  Future<bool> addProduct() async {
    newProduct.value.isExpiration =
        newProduct.value.expiration!.isBefore(DateTime.now());
    final save = SaveProduct(product: newProduct.value, amount: amount.value);
    final result = await CompanyRepository().addProduct(save);
    return result;
  }
}
