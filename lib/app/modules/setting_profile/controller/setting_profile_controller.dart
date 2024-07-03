import 'dart:ui';

import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_type_model.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/modules/admin/data/charity_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/company_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/user_repo.dart';
import 'package:marketing_surplus/app/routes/app_routes.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../data/model/charity.dart';
import '../../../data/model/company.dart';
import '../../../data/model/pay_method.dart';
import '../../../data/model/user_model.dart';
import '../../admin/data/company_type_repo.dart';
import '../../admin/data/order_repo.dart';
import '../../admin/data/pay_method_repo.dart';
import '../data/profail_repo.dart';

class SettingProfileController extends GetxController {
  final kind = true.obs;
  final loading = false.obs;
  final isNotEdit = true.obs;
  final authType = Auth.user.obs;
  final companyTypes = <CompanyTypeModel>[].obs;
  final typeRepo = CompanyTypeRepository();
  final companyRepo = CompanyRepository();
  final userRepo = UsersDataRepository();
  final charityRepo = CharityRepository();
  final profRepo = ProfailRepository();
  final auth = Get.find<AuthService>();
  final company = Company().obs;
  final user = UserModel().obs;
  final charity = Charity().obs;
  final pays = <PayMethod>[].obs;
  final orderProducts = <OrderProduct>[].obs;
  final companyUsers = <UserModel>[].obs;
  final listTextTabToggle = ["عربي", "English"];
  RxInt tabTextIndexSelected = 0.obs;

  void toggle(int index) {
    tabTextIndexSelected.value = index;
    if (index == 0) {
      Get.updateLocale(Locale('ar', 'AR'));
    } else {
      Get.updateLocale(Locale('en', 'EN'));
    }
  }

  @override
  void onInit() {
    getDataperson();
    getAllCompanyType();
    getPayMethod();
    getLastOrder();
    getAllUserSubs();
    super.onInit();
  }

  Future<void> getPayMethod() async {
    final result = await PayMethodRepositry().getAllMethod();
    pays.assignAll(result);
  }

  Future<void> getAllUserSubs() async {
    if (auth.getTypeEnum() == Auth.comapny) {
      final id = (auth.getDataFromStorage() as Company).id!;
      var result = await profRepo.GetAllCompanyUsers(id);
      companyUsers.assignAll(result);
    }
  }

  Future<void> getLastOrder() async {
    final result = await OrderDataRepository().getOrderDetails();
    var data = result.where((p0) => p0.bills!.last.orderStatusId == 4);
    orderProducts.addAll(data);
  }

  Future<void> getAllCompanyType() async {
    // companyTypes.assignAll([
    //   CompanyTypeModel(type: 'Medicines', id: 1),
    //   CompanyTypeModel(type: 'Sports', id: 2),
    //   CompanyTypeModel(type: 'Clothes', id: 3),
    //   CompanyTypeModel(type: 'Food', id: 4)
    // ]);
    var data = await typeRepo.getCompanyType();
    companyTypes.assignAll(data);
  }

  Future<void> getDataperson() async {
    loading.value = true;

    switch (auth.personType()) {
      case 'user':
        authType.value = Auth.user;
        user.value = auth.getDataFromStorage() as UserModel;
        break;
      case 'comapny':
        authType.value = Auth.comapny;
        company.value = auth.getDataFromStorage() as Company;
        // await getContentComapny(company.value.id!);
        // await getPostCompany(company.value.id!);
        // await getfllowerCompany((auth.getDataFromStorage() as Company).email!);
        // await getfllowerCompanyCount(
        //     (auth.getDataFromStorage() as Company).email!);

        break;
      case 'charity':
        authType.value = Auth.charity;
        charity.value = auth.getDataFromStorage() as Charity;
        // await getContentInful(infulencer.value.id!);
        // await getPostInful(infulencer.value.id!);
        // await getfllowerInful((auth.getDataFromStorage() as Infulonser).email!);
        // await getfllowerInfulCount(
        //     (auth.getDataFromStorage() as Infulonser).email!);
        break;
    }
    loading.value = false;
  }

  Future<void> updateObject() async {
    loading.value = true;

    switch (authType.value) {
      case Auth.user:
        await userRepo.updateUser(user.value);
        auth.stroge.deleteAllKeys();
        auth.logIn(user.value.email!, user.value.password!);
        break;
      case Auth.comapny:
        await companyRepo.updateCompany(company.value);
        auth.stroge.deleteAllKeys();
        auth.logIn(company.value.email!, company.value.password!);
        break;
      case Auth.charity:
        await charityRepo.updateCharity(charity.value);
        auth.stroge.deleteAllKeys();
        auth.logIn(charity.value.email!, charity.value.password!);
        break;
      case Auth.none:
        break;
    }
    loading.value = false;
  }

  Future<void> deleteAccount() async {
    bool res = false;
    if (auth.getTypeEnum() == Auth.comapny) {
      var id = (auth.getDataFromStorage() as Company).id!;
      res = await companyRepo.deleteCompany(id);
    } else if (auth.getTypeEnum() == Auth.charity) {
      var id = (auth.getDataFromStorage() as Charity).id!;
      res = await charityRepo.deleteCharity(id);
    } else if (auth.getTypeEnum() == Auth.user) {
      var id = (auth.getDataFromStorage() as UserModel).id!;
      res = await userRepo.deleteUser(id);
    }
    if (res) {
      auth.stroge.deleteAllKeys();
      Overlayment.dismissLast();
      Get.rootDelegate.offAndToNamed(Paths.LogIn);
    }
  }
}
