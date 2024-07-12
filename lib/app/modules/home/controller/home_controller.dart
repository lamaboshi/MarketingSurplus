import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketing_surplus/app/data/model/company.dart';
import 'package:marketing_surplus/app/data/model/company_product_dto.dart';
import 'package:marketing_surplus/app/data/model/product.dart';
import 'package:marketing_surplus/app/data/model/save_product.dart';
import 'package:marketing_surplus/app/data/model/subscription.dart';
import 'package:marketing_surplus/app/data/model/user_model.dart';
import 'package:marketing_surplus/app/modules/home/data/post_repo.dart';
import 'package:marketing_surplus/app/modules/home/view/main_company_page.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../api/storge/storge_service.dart';
import '../../../../shared/service/auth_service.dart';
import '../../../../shared/service/util.dart';
import '../../../data/model/company_product.dart';
import '../../../data/model/company_type_model.dart';
import '../../../data/model/evalution.dart';
import '../../../data/model/order_model.dart';
import '../../admin/data/company_repo.dart';
import '../../admin/data/company_type_repo.dart';
import '../../admin/data/order_repo.dart';
import '../../admin/data/rate_repo.dart';
import '../../bills/view/bills_page.dart';
import '../../charity/view/charity_view.dart';
import '../../menu/view/menu_company_page.dart';
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
  final selectType = CompanyTypeModel().obs;
  final rates = <Evalution>[].obs;
  final orders = <OrderModel>[].obs;
  final orderRepo = OrderDataRepository();
  final rateRepo = RateRepository();
  final isAll = true.obs;
  final isAccept = false.obs;
  final isloading = false.obs;
  final stringPickImage = ''.obs;
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
  final select = ['drop-all', 'drop-sub'];

  @override
  void onInit() {
    selectType.value = CompanyTypeModel();
    getData();

    getPosts();
    getAllCompanyType();
    super.onInit();
  }

  void isNew() {
    var isNewData = auth.stroge.containsKey('regierterComp');
    if (isNewData) {
      Overlayment.showMessage(
          icon: Icon(
            Icons.album_sharp,
            color: Colors.purple.shade400,
          ),
          'Hello Welcome To -Clout- You should Add your own PayMethods From Settings and Your Product to reach orders from Customer ,there help page to help you  -Welcome Again-');
      auth.stroge.deleteDataByKey('regierterComp');
    }
  }

  Future<void> getData() async {
    if (auth.getTypeEnum() == Auth.comapny) {
      final object = (auth.getDataFromStorage() as Company);

      await getAllOrders();
      await getRates();
      await getAllProduct(object.id!);
      isAccept.value = true;
    }
  }

//TODO MM reomve
  Future<void> getAllOrders() async {
    var data = await orderRepo.getOrders();

    orders.assignAll(data);
  }

  Future<void> getRates() async {
    final id = (auth.getDataFromStorage() as Company).id!;
    var data = await rateRepo.getRates(id);
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
    companies.clear();
    if (!auth.isAuth() || auth.getTypeEnum() == Auth.charity) {
      final data = await mainRepo.getAllPosts(0);
      data.shuffle();
      sortList(data, isAllData: isAllData);
      isloading.value = false;
      return;
    }

    if (auth.getTypeEnum() == Auth.user) {
      final userId = (auth.getDataFromStorage() as UserModel).id!;

      if (isAll.value) {
        getData();
        getAllCompanyType();
        final data = await mainRepo.getAllPosts(userId);
        data.shuffle();
        sortList(data, isAllData: isAllData);
      } else {
        companies.clear();
        final data = await mainRepo.getSubscriptionPosts(userId);
        data.shuffle();
        listPosts.assignAll(data);
        for (var e in data) {
          if (!companies.any((element) =>
              element.companyProduct!.company!.id ==
              e.companyProduct!.company!.id)) {
            companies.assign(e);
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
    if (selectType.value.id == null) return;
    if (auth.getTypeEnum() == Auth.user) {
      final userId = (auth.getDataFromStorage() as UserModel).id!;

      final list = await mainRepo.getAllPosts(userId);
      var data =
          list.where((p0) => p0.type!.id == selectType.value.id).toList();
      listPosts.clear();
      companies.clear();
      sortList(data);
    } else {
      final list = await mainRepo.getAllPosts(0);
      var data =
          list.where((p0) => p0.type!.id == selectType.value.id).toList();

      listPosts.clear();
      companies.clear();
      sortList(data);
    }
  }

  void sortList(List<CompanyProductDto> data, {bool isAllData = false}) {
    listPosts.clear();
    companies.clear();
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

  Future pickImageFun() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      stringPickImage.value = Utility.base64String(await image.readAsBytes());
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<bool> addProduct() async {
    newProduct.value.isExpiration =
        newProduct.value.expiration!.isBefore(DateTime.now());
    final save = SaveProduct(product: newProduct.value, amount: amount.value);
    final result = await companyRepo.addProduct(save);
    onInit();
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
    const MenuCompanyPage(),
    const CharityView(),
    const ProfileView()
  ];
}
