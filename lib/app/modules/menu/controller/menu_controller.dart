import 'package:get/get.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../data/model/company_product_dto.dart';
import '../../../data/model/user_model.dart';
import '../../home/data/post_repo.dart';

class MenuController extends GetxController {
  final toggleValue = 0.obs;
  final listPosts = <CompanyProductDto>[].obs;
  final auth = Get.find<AuthService>();
  final mainRepo = PostRepository();
  @override
  void onInit() {
    getPosts();
    super.onInit();
  }

  Future<void> getPosts() async {
    if (!auth.isAuth()) {
      final data = await mainRepo.getAllPosts(0);
      listPosts.assignAll(data);
      return;
    }

    if (auth.getTypeEnum() == Auth.user) {
      final userId = (auth.getDataFromStorage() as UserModel).id!;

      listPosts.clear();

      final data = await mainRepo.getAllPosts(userId);
      listPosts.assignAll(data);
    }
  }
}
