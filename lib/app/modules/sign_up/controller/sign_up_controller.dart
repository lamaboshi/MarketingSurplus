import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketing_surplus/app/modules/admin/data/charity_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/user_repo.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../../shared/service/util.dart';
import '../../../data/model/charity.dart';
import '../../../data/model/company.dart';
import '../../../data/model/company_type_model.dart';
import '../../../data/model/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../admin/data/company_repo.dart';
import '../../admin/data/company_type_repo.dart';

class SignUpController extends GetxController {
  final authType = Auth.user.obs;
  final companyTypes = <CompanyTypeModel>[].obs;
  final typeRepo = CompanyTypeRepository();
  final passwordVisible = false.obs;
  final userPasswordController = TextEditingController();
  final selectedType = CompanyTypeModel().obs;
  final isloading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getAllCompanyType();
  }

  String? forceValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'requird';
    }
    return null;
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

  final isShownUser = false.obs;
  final isShownInfluencer = false.obs;
  final isShownCompany = false.obs;
  final isSaveData = false.obs;
  final stringPickImage = ''.obs;
  final company = Company(
    id: 0,
    address: 'United Arab Emirates.',
    description: 'some description',
    email: 'comedy@test.com',
    name: 'comedy',
    telePhone: '68465458564',
    password: '5678',
    companyTypeId: 1,
    phone: '156518686',
  ).obs;
  final user = UserModel(
    id: 0,
    age: 22,
    email: 'userModel@test.com',
    name: 'UserTest',
    password: '1234',
    paypal: 'CodeThis',
    phone: '09468468',
    userName: 'User13',
  ).obs;
  final charity = Charity(
    id: 0,
    associationLicense: '2435',
    address: 'Al Hamadanieh exmp',
    email: 'Al-Ihsan@testexmp.com ',
    name: 'Al-Ihsan exmp',
    password: 'Al-Ihsan789 exmp',
    goals: 'childern exmp',
    phone: '0215789147 exmp',
    targetGroup: 'Rich Pepole exmp',
  ).obs;
  final userForm = GlobalKey<FormState>();
  final influencerForm = GlobalKey<FormState>();
  final companyForm = GlobalKey<FormState>();
  final companyRpo = CompanyRepository();
  final userRpo = UsersDataRepository();
  final charityRepo = CharityRepository();
  final auth = Get.find<AuthService>();
  final newType = CompanyTypeModel().obs;
  Future<void> signUpCompany() async {
    company.value.image = Utility.dataFromBase64String(stringPickImage.value);
    var data = await companyRpo.regierterComp(company.value);
    if (data) {
      auth.stroge.saveData('regierterComp', 'New One');
      stringPickImage.value = '';
      Overlayment.dismissLast();
      Get.rootDelegate.toNamed(Paths.LogIn);
    }
  }

  Future<void> signUpUser() async {
    user.value.image = Utility.dataFromBase64String(stringPickImage.value);
    var data = await userRpo.regierterUser(user.value);
    if (data) {
      stringPickImage.value = '';
      Overlayment.dismissLast();
      Get.rootDelegate.toNamed(Paths.LogIn);
    }
  }

  Future<void> signUpCharity() async {
    charity.value.image = Utility.dataFromBase64String(stringPickImage.value);
    var data = await charityRepo.regierterCharity(charity.value);
    if (data) {
      stringPickImage.value = '';
      Overlayment.dismissLast();
      Get.rootDelegate.toNamed(Paths.LogIn);
    }
  }

  Future<void> getAllCompanyType() async {
    // companyTypes.assignAll([
    //   CompanyTypeModel(type: 'Medicines', id: 1),
    //   CompanyTypeModel(type: 'Sports', id: 2),
    //   CompanyTypeModel(type: 'Clothes', id: 3),
    //   CompanyTypeModel(type: 'Food', id: 4)
    // ]);
    isloading.value = true;

    var data = await typeRepo.getCompanyType();
    companyTypes.assignAll(data);
    selectedType.value = companyTypes.first;
    isloading.value = false;
  }

  dynamic getObject() {
    switch (authType.value) {
      case Auth.user:
        return user;
      case Auth.comapny:
        return company;
      case Auth.charity:
        return charity;
      case Auth.none:
      // TODO: Handle this case.
    }
  }

  Future<void> addCompanyTypeModelelement(
      CompanyTypeModel companyTypeModel) async {
    var res = await typeRepo.addCompanyType(companyTypeModel);
    if (res) {
      Overlayment.dismissLast();
      companyTypes.clear();
      await getAllCompanyType();
      var item = companyTypes
          .where((p0) => p0.type!.contains(companyTypeModel.type!))
          .first;
      company.value.companyTypeId = item.id;
      selectedType.value = item;
    }
  }

  @override
  void onClose() {}
}
