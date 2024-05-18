import 'dart:convert';

import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product_dto.dart';
import 'package:marketing_surplus/app/data/model/subscription.dart';
import 'package:marketing_surplus/app/data/model/user_model.dart';
import 'package:marketing_surplus/app/modules/home/data/post_repo.dart';

import '../../../../api/storge/storge_service.dart';
import '../../../../shared/service/auth_service.dart';
import '../../../data/model/company_type_model.dart';
import '../../admin/data/company_type_repo.dart';
import '../../bills/view/bills_page.dart';
import '../../menu/view/menu_page.dart';
import '../../profile/view/profile_page.dart';
import '../../setting_profile/data/profail_repo.dart';
import '../view/main_page.dart';

class HomeController extends GetxController {
  final pageIndex = 0.obs;
  final listPosts = <CompanyProductDto>[].obs;
  final companyTypes = <CompanyTypeModel>[].obs;
  final auth = Get.find<AuthService>();
  final mainRepo = PostRepository();
  final profileRepo = ProfailRepository();
  final typeRepo = CompanyTypeRepository();
  final selecetType = CompanyTypeModel().obs;
  final isAll = true.obs;
  final select = ['Suggested Company', 'Subscription Company'];
  @override
  void onInit() {
    getPosts();
    getAllCompanyType();
    super.onInit();
  }

  Future<void> saveSelectedCompany(CompanyProductDto productDto) async {
    const key = 'select-company';
    final stroge = Get.find<StorageService>();
    if (stroge.containsKey(key)) {
      await stroge.deleteDataByKey(key);
    }

    stroge.saveData(key, json.encode(productDto.toJson()));
  }

  Future<void> getAllCompanyType() async {
    var data = await typeRepo.getCompanyType();
    companyTypes.assignAll(data);
  }

  Future<void> getPosts() async {
    listPosts.clear();

    if (!auth.isAuth()) {
      final data = await mainRepo.getAllPosts(0);
      listPosts.assignAll(data);
      return;
    }

    if (auth.getTypeEnum() == Auth.user) {
      final userId = (auth.getDataFromStorage() as UserModel).id!;

      if (isAll.value) {
        final data = await mainRepo.getAllPosts(userId);
        listPosts.assignAll(data);
      } else {
        final data = await mainRepo.getSubscriptionPosts(userId);
        listPosts.assignAll(data);
      }
    }
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
      listPosts.assignAll(data);
    }
  }

  final pageList = [
    const MainView(),
    MenView(),
    const BillsView(),
    const ProfileView()
  ];
}
