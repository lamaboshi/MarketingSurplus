import 'dart:convert';

import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product.dart';
import 'package:marketing_surplus/app/data/model/company_product_dto.dart';

import '../../../../api/storge/storge_service.dart';
import '../../../../shared/service/auth_service.dart';
import '../../../data/model/rate.dart';
import '../../../data/model/subscription.dart';
import '../../../data/model/user_model.dart';
import '../../admin/data/company_repo.dart';
import '../../admin/data/rate_repo.dart';
import '../../setting_profile/data/profail_repo.dart';

class CompanyController extends GetxController {
  final products = <CompanyProduct>[].obs;
  final companyRepo = CompanyRepository();
  final dto = CompanyProductDto().obs;
  final auth = Get.find<AuthService>();
  final profileRepo = ProfailRepository();
  final rateRepo = RateRepository();
  final companyName = ''.obs;
  final rate = 0.0.obs;
  final count = 0.obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    dto.value = getSelectedCompany();
    getAllProduct(dto.value.companyProduct!.company!.id!);

    getCount();
    super.onInit();
  }

  CompanyProductDto getSelectedCompany() {
    const key = 'select-company';
    final stroge = Get.find<StorageService>();
    final data = json.decode(stroge.getData(key)!);
    print(data);
    return CompanyProductDto.fromJson(data as Map<String, dynamic>);
  }

  Future<void> addToBasket(CompanyProduct product) async {
    await auth.addToBasket(product);
    count.value = await getCount();
  }

  Future<void> getAllProduct(int companyId) async {
    isLoading.value = true;
    final data = await companyRepo.getAllCompanyProduct(companyId);
    products.assignAll(data);
    isLoading.value = false;
  }

  Future<int> getCount() async {
    final re = (await auth.getDataBasket()).length;
    count.value = re;
    return re;
  }

  Future<void> addRate(Rate rate, int subId) async {
    await rateRepo.regierterRate(rate, subId);
    dto.value.rateNumber = rate.rateNumber;
  }

  Future<void> addSubscription(int companyId) async {
    if (auth.getTypeEnum() == Auth.user) {
      final userId = (auth.getDataFromStorage() as UserModel).id!;
      final result = await profileRepo.addSubscription(
          Subscription(id: 0, companyId: companyId, userId: userId));
      if (result) {
        await getAllProduct(companyId);
      }
    }
  }
}
