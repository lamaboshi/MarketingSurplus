import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../../shared/service/util.dart';
import '../../../data/model/company.dart';
import '../../../data/model/company_type_model.dart';
import '../../../data/model/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../admin/data/company_type_repo.dart';
import '../data/companu_repo.dart';
import '../data/user_repo.dart';

class SignUpController extends GetxController {
  final isCompany = false.obs;
  final companyTypes = <CompanyTypeModel>[].obs;
  final typeRepo = CompanyTypeRepository();

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

  final companyRpo = CompanyRepository();
  final userRpo = UserRepository();

  final auth = Get.find<AuthService>();

  Future<void> signUpCompany() async {
    //   company.value.image = Utility.dataFromBase64String(stringPickImage.value);
    var data = await companyRpo.regierterComp(company.value);
    if (data) {
      await auth.logIn(company.value.email!, company.value.password!);
      Get.rootDelegate.toNamed(Paths.HOME);
    }
  }

  Future<void> signUpUser() async {
    // user.value.image = Utility.dataFromBase64String(stringPickImage.value);
    var data = await userRpo.regierterUser(user.value);
    if (data) {
      await auth.logIn(user.value.email!, user.value.password!);
      Get.rootDelegate.toNamed(Paths.HOME);
    }
  }

  Future<void> getAllCompanyType() async {
    var data = await typeRepo.getCompanyType();
    companyTypes.assignAll(data);
  }

  @override
  void onClose() {}
}
