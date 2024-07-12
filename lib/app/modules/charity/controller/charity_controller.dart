import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/charity.dart';
import 'package:marketing_surplus/app/data/model/company.dart';
import 'package:marketing_surplus/app/data/model/donation.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';
import 'package:marketing_surplus/shared/service/order_service.dart';

import '../../../data/model/order_type.dart';
import '../../admin/data/charity_repo.dart';

class CharityController extends GetxController {
  final auth = Get.find<AuthService>();
  final allDonationCompany = <Donation>[].obs;
  final allCharity = <Charity>[].obs;
  final orderTypes = <OrderType>[].obs;
  final lastOrderCharity = <Donation>[].obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    if (auth.getTypeEnum() == Auth.comapny) {
      await getAllDonationForCompany();
      await getCharities();
      await getOrderType();
      await getLastOrderCharity();
    }
  }

  Future<void> getAllDonationForCompany() async {
    isLoading.value = true;
    var id = (auth.getDataFromStorage() as Company).id!;
    final data = await OrderService().getAllDonationForCompany(id);
    allDonationCompany.assignAll(data);
    print(
        '-------------------getAllDonationForCompany with ${data.length}--------------------');
    isLoading.value = false;
  }

  Future<void> getCharities() async {
    isLoading.value = true;
    final data = await CharityRepository().getCharities();
    allCharity.assignAll(data);
    print(
        '-------------------getCharities with ${data.length}--------------------');
    isLoading.value = false;
  }

  Future<void> getLastOrderCharity() async {
    isLoading.value = true;
    var id = (auth.getDataFromStorage() as Company).id!;
    final result = await OrderService().getAllDonationForCompany(id);
    lastOrderCharity.assignAll(result);
    print(
        '-------------------getAllDonationForCompany with ${result.length}--------------------');
    isLoading.value = false;
  }

  Future<void> getOrderType() async {
    final result = await OrderService().getOrderType();
    orderTypes.assignAll(result);
  }
}
