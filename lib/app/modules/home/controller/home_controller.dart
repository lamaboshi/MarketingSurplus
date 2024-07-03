import 'dart:convert';

import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company.dart';
import 'package:marketing_surplus/app/data/model/company_product_dto.dart';
import 'package:marketing_surplus/app/data/model/product.dart';
import 'package:marketing_surplus/app/data/model/save_product.dart';
import 'package:marketing_surplus/app/data/model/subscription.dart';
import 'package:marketing_surplus/app/data/model/user_model.dart';
import 'package:marketing_surplus/app/modules/home/data/post_repo.dart';
import 'package:marketing_surplus/app/modules/home/view/main_company_page.dart';

import '../../../../api/storge/storge_service.dart';
import '../../../../shared/service/auth_service.dart';
import '../../../data/model/company_product.dart';
import '../../../data/model/company_type_model.dart';
import '../../../data/model/order_model.dart';
import '../../../data/model/rate.dart';
import '../../admin/data/company_repo.dart';
import '../../admin/data/company_type_repo.dart';
import '../../admin/data/order_repo.dart';
import '../../admin/data/rate_repo.dart';
import '../../bills/view/bills_page.dart';
import '../../menu/view/menu_page.dart';
import '../../profile/view/profile_page.dart';
import '../../setting_profile/data/profail_repo.dart';
import '../view/main_page.dart';

class HomeController extends GetxController {
  final pageIndex = 0.obs;
  final listPosts = <CompanyProductDto>[].obs;
  final companies = <CompanyProductDto>[].obs;
  final companyTypes = <CompanyTypeModel>[].obs;
  final auth = Get.find<AuthService>();
  final mainRepo = PostRepository();
  final profileRepo = ProfailRepository();
  final typeRepo = CompanyTypeRepository();
  final selecetType = CompanyTypeModel().obs;
  final rates = <Rate>[].obs;
  final orders = <OrderModel>[].obs;
  final orderRepo = OrderDataRepository();
  final rateRepo = RateRepository();
  final isAll = true.obs;
  final isAccept = false.obs;
  final isloading = false.obs;

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
  final companyRepo = CompanyRepository();
  final select = ['Suggested Company', 'Subscription Company'];

  @override
  void onInit() {
    getData();

    getPosts();
    getAllCompanyType();
    super.onInit();
  }

  Future<void> getData() async {
    if (auth.getTypeEnum() == Auth.comapny) {
      final object = (auth.getDataFromStorage() as Company);
      if (object.isAccept!) {
        await getAllOrders();
        await getRates();
        await getAllProduct(object.id!);
        isAccept.value = true;
      }
    }
  }

  Future<void> getAllOrders() async {
    var data = await orderRepo.getOrders();
    orders.assignAll(data);
  }

  Future<void> getRates() async {
    var data = await rateRepo.getRates();
    rates.assignAll(data);
  }

  Future<void> saveSelectedCompany(CompanyProductDto productDto) async {
    const key = 'select-company';
    final stroge = Get.find<StorageService>();
    if (stroge.containsKey(key)) {
      await stroge.deleteDataByKey(key);
    }

    stroge.saveData(key, json.encode(productDto.toJson()));
    print(productDto.companyProduct!.company!.name!);
  }

  Future<void> getAllCompanyType() async {
    var data = await typeRepo.getCompanyType();
    companyTypes.assignAll(data);
  }

  Future<void> getPosts({bool isAllData = false}) async {
    isloading.value = true;
    listPosts.clear();

    if (!auth.isAuth()) {
      final data = await mainRepo.getAllPosts(0);
      sortList(data, isAllData: isAllData);
      return;
    }

    if (auth.getTypeEnum() == Auth.user) {
      final userId = (auth.getDataFromStorage() as UserModel).id!;

      if (isAll.value) {
        getData();
        getAllCompanyType();
        final data = await mainRepo.getAllPosts(userId);
        sortList(data, isAllData: isAllData);
      } else {
        companies.clear();
        final data = await mainRepo.getSubscriptionPosts(userId);

        listPosts.assignAll(data);
        for (var e in data) {
          if (!companies.any((element) =>
              element.companyProduct!.company!.id ==
              e.companyProduct!.company!.id)) {
            companies.add(e);
          }
        }
      }
    }
    isloading.value = false;
  }

  Future<void> getAllProduct(int companyId) async {
    final data = await companyRepo.getAllCompanyProduct(companyId);
    products.assignAll(data);
    print(products.length);
  }

  Future<void> addSubscription(int companyId) async {
    if (auth.getTypeEnum() == Auth.user) {
      final userId = (auth.getDataFromStorage() as UserModel).id!;
      final result = await profileRepo.addSubscription(
          Subscription(id: 0, companyId: companyId, userId: userId));
      if (result) {
        getPosts();
        getAllCompanyType();
      }
    }
  }

  Future<void> filterByType() async {
    if (selecetType.value.id == null) return;
    if (auth.getTypeEnum() == Auth.user) {
      final userId = (auth.getDataFromStorage() as UserModel).id!;

      final list = await mainRepo.getAllPosts(userId);
      var data =
          list.where((p0) => p0.type!.id == selecetType.value.id).toList();
      listPosts.clear();
      sortList(data);
    }
  }

  void sortList(List<CompanyProductDto> data, {bool isAllData = false}) {
    var items = isAllData ? data : data.take(20);
    listPosts.assignAll(items);
    for (var e in data) {
      if (!companies.any((element) =>
          element.companyProduct!.company!.id ==
          e.companyProduct!.company!.id)) {
        companies.add(e);
      }
    }
  }

  Future<bool> addProduct() async {
    newProduct.value.isExpiration =
        newProduct.value.expiration!.isBefore(DateTime.now());
    final save = SaveProduct(product: newProduct.value, amount: amount.value);
    final result = await companyRepo.addProduct(save);
    return result;
  }

  final pageList = [
    const MainView(),
    MenView(),
    const BillsView(),
    const ProfileView()
  ];
  final pageListCompany = [
    const MainCompanyPage(),
    MenView(),
    const BillsView(),
    const ProfileView()
  ];
}
