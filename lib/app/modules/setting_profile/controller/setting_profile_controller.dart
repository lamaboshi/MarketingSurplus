import 'dart:ui';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketing_surplus/app/data/model/company_type_model.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/modules/admin/data/charity_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/company_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/user_repo.dart';
import 'package:marketing_surplus/app/routes/app_routes.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../../shared/service/order_service.dart';
import '../../../../shared/service/util.dart';
import '../../../data/model/charity.dart';
import '../../../data/model/company.dart';
import '../../../data/model/order_type.dart';
import '../../../data/model/pay_method.dart';
import '../../../data/model/product_donation.dart';
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
  final orderTypes = <OrderType>[].obs;
  final newOrderType = OrderType().obs;
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
  final lastOrderCharity = <ProductDonation>[].obs;
  final stringPickImage = ''.obs;
  final listTextTabToggle = ["عربي", "English"];
  RxInt tabTextIndexSelected = 0.obs;
  final isLoading = false.obs;
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
    getData();
    getOrderType();
    getAllUserSubs();
    super.onInit();
  }

  Future<void> getPayMethod() async {
    final result = await PayMethodRepositry().getAllMethod();
    pays.assignAll(result);
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

  Future<void> getData() async {
    if (auth.getTypeEnum() == Auth.user) {
      await getLastOrder();
    } else if (auth.getTypeEnum() == Auth.charity) {
      await getLastOrderCharity();
    } else {
      getOrderDetailsForCompany();
    }
  }

  Future<void> getOrderType() async {
    final result = await OrderService().getOrderType();
    orderTypes.assignAll(result);
  }

  Future<void> getLastOrderCharity() async {
    final result = await OrderService().getAllDonation();
    lastOrderCharity.assignAll(result);
  }

  Future<void> getOrderDetailsForCompany() async {
    isLoading.value = true;
    final data = await OrderService().getOrderDetailsForCompany();
    print(
        '--------------------------------getOrderDetailsForCompany with ${data.length}------------------');

    orderProducts.assignAll(data);

    isLoading.value = false;
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
        if (stringPickImage.value.isNotEmpty) {
          user.value.image =
              Utility.dataFromBase64String(stringPickImage.value);
        }

        await userRepo.updateUser(user.value);
        auth.stroge.deleteAllKeys();
        auth.logIn(user.value.email!, user.value.password!);
        break;
      case Auth.comapny:
        if (stringPickImage.value.isNotEmpty) {
          company.value.image =
              Utility.dataFromBase64String(stringPickImage.value);
        }

        await companyRepo.updateCompany(company.value);
        auth.stroge.deleteAllKeys();
        auth.logIn(company.value.email!, company.value.password!);
        break;
      case Auth.charity:
        if (stringPickImage.value.isNotEmpty) {
          charity.value.image =
              Utility.dataFromBase64String(stringPickImage.value);
        }

        await charityRepo.updateCharity(charity.value);
        auth.stroge.deleteAllKeys();
        auth.logIn(charity.value.email!, charity.value.password!);
        break;
      case Auth.none:
        break;
    }
    isNotEdit.value = true;
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
