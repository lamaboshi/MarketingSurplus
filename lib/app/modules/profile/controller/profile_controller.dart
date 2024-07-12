import 'dart:math';

import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';

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
  int randomValue() => rng.nextInt(10);
  final details = <Map>[].obs;
  final value = 0.obs;
  final banfi = [
    {
      'Reducing pressure on waste':
          'Companies can take advantage of excess capacity to reduce the amount of waste and dispose of it more effectively.'
    },
    {
      'Improving environmental sustainability':
          'Sustainable consumption can contribute to preserving the environment and reducing the impact of human activities.'
    },
    {
      'Saving scarce natural resources':
          'Companies can reduce the consumption of scarce resources through excess capacity.'
    },
    {
      'Improving the circular economy':
          'Surplus products can be part of a sustainable economic cycle.'
    },
    {
      'Promoting sustainability awareness':
          'Companies can direct attention to sustainability issues through excess capacity.'
    },
    {
      'Improving food security':
          'Surplus produce can contribute to providing food to local communities.'
    },
    {
      'Reducing dependence on petroleum materials':
          'Companies can reduce the use of petroleum materials through excess capacity.'
    },
    {
      'Improve supplier relationships':
          'Companies can exchange surplus products with suppliers and enhance cooperation.'
    },
    {
      'Achieving financial sustainability':
          'Companies can achieve financial sustainability through excess capacity.'
    },
    {
      'Promoting social innovation':
          'Surplus products can contribute to solving social and economic problems',
    }
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
      if (date.inDays <= 3) {
        products.assign(element);
      }
    }
  }

  void getsaveOrder() {
    saved.value = 0.0;
    details.clear();
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

  Future<bool> addProduct() async {
    newProduct.value.isExpiration =
        newProduct.value.expiration!.isBefore(DateTime.now());
    final save = SaveProduct(product: newProduct.value, amount: amount.value);
    final result = await CompanyRepository().addProduct(save);
    return result;
  }
}
