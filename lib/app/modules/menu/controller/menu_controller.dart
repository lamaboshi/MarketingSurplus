import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/home/controller/home_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../data/model/company_product.dart';
import '../../../data/model/company_product_dto.dart';
import '../../../data/model/company_type_model.dart';
import '../../../data/model/product.dart';
import '../../../data/model/save_product.dart';
import '../../admin/data/company_repo.dart';
import '../../home/data/post_repo.dart';

class MenuController extends GetxController {
  final toggleValue = 0.obs;
  final listPosts = <CompanyProductDto>[].obs;
  final auth = Get.find<AuthService>();
  final mainRepo = PostRepository();
  final products = <CompanyProduct>[].obs;
  final companies = <CompanyProductDto>[].obs;
  final companyTypes = <CompanyTypeModel>[].obs;
  final companyRepo = CompanyRepository();
  final companySearch = CompanyProductDto().obs;
  final companyTypeSearch = CompanyTypeModel().obs;
  final homeController = Get.find<HomeController>();
  final isEmptyData = true.obs;
  final count = 0.obs;
  final newProduct = Product(
          name: 'test',
          descripation: 'Some Data',
          expiration: DateTime.now().add(const Duration(days: 2)),
          dateTime: DateTime.now(),
          oldPrice: 300,
          newPrice: 100)
      .obs;
  final amount = 0.obs;
  @override
  void onInit() {
    getPosts();

    getIsEmpty();
    getCount();
    super.onInit();
  }

  Future<void> addToBasket(CompanyProduct product) async {
    var data = await auth.getDataBasket();
    if (data.isEmpty ||
        data.any((element) => element.company!.id == product.company!.id)) {
      await auth.addToBasket(product);
      count.value = await getCount();
    } else {
      var snackBar = SnackBar(
          duration: Duration(seconds: 1),
          content: Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              'You Cannot Make Order from many Company',
              style: TextStyle(color: Colors.purple.shade200, fontSize: 18),
            ),
          ));
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  Future<bool> addProduct() async {
    newProduct.value.isExpiration =
        newProduct.value.expiration!.isBefore(DateTime.now());
    final save = SaveProduct(product: newProduct.value, amount: amount.value);
    final result = await companyRepo.addProduct(save);
    return result;
  }

  void getIsEmpty() {
    if (auth.getTypeEnum() == Auth.comapny) {
      isEmptyData.value = products.isEmpty;
    } else {
      isEmptyData.value = listPosts.isEmpty;
    }
  }

  Future<int> getCount() async {
    final re = (await auth.getDataBasket()).length;
    count.value = re;
    return re;
  }

  Future<void> getPosts() async {
    listPosts.assignAll(homeController.listPosts);
    products.assignAll(homeController.products);
    companies.assignAll(homeController.companies);
    companyTypes.assignAll(homeController.companyTypes);
  }

  void filter() {
    listPosts.assignAll(homeController.listPosts);
    if (companySearch.value.companyProduct != null) {
      var data = listPosts
          .where((p0) =>
              p0.companyProduct!.company!.id ==
              companySearch.value.companyProduct!.company!.id)
          .toList();
      listPosts.assignAll(data);
    } else {
      var data = listPosts
          .where((p0) => p0.type!.id == companyTypeSearch.value.id)
          .toList();
      listPosts.assignAll(data);
    }
    print(listPosts.length);
    companyTypeSearch.value = CompanyTypeModel();
    companySearch.value = CompanyProductDto();
    companies.assignAll(homeController.companies);
    Overlayment.dismissLast();
  }
}
