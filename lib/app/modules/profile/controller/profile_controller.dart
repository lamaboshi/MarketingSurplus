import 'dart:math';

import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';

import '../../admin/data/order_repo.dart';

class ProfileController extends GetxController {
  final lastOrder = <OrderProduct>[].obs;
  final auth = Get.find<AuthService>();
  final saved = 0.0.obs;
  var rng = Random();
  int randomValue() => rng.nextInt(10);
  final details = <Map>[].obs;
  final value = 0.obs;
  final banfi = [
    {
      'Reducing pressure on waste':
          'Companies can take advantage of excess capacity to reduce the amount of waste and dispose of it more effectively.'
    },
    {
      'Improving environmental sustainability':
          'Sustainable consumption can contribute to preserving the environment and reducing the impact of human activities.'
    },
    {
      'Saving scarce natural resources':
          'Companies can reduce the consumption of scarce resources through excess capacity.'
    },
    {
      'Improving the circular economy':
          'Surplus products can be part of a sustainable economic cycle.'
    },
    {
      'Promoting sustainability awareness':
          'Companies can direct attention to sustainability issues through excess capacity.'
    },
    {
      'Improving food security':
          'Surplus produce can contribute to providing food to local communities.'
    },
    {
      'Reducing dependence on petroleum materials':
          'Companies can reduce the use of petroleum materials through excess capacity.'
    },
    {
      'Improve supplier relationships':
          'Companies can exchange surplus products with suppliers and enhance cooperation.'
    },
    {
      'Achieving financial sustainability':
          'Companies can achieve financial sustainability through excess capacity.'
    },
    {
      'Promoting social innovation':
          'Surplus products can contribute to solving social and economic problems',
    }
  ];
  @override
  void onInit() {
    getLastOrder();
    getsaveOrder();
    value.value = randomValue();
    super.onInit();
  }

  Future<void> getLastOrder() async {
    final result = await OrderDataRepository().getOrderDetails();
    var data = result.where((p0) => p0.bills!.last.orderStatusId == 4);
    lastOrder.assignAll(data);
  }

  void getsaveOrder() {
    saved.value = 0.0;
    for (var element in lastOrder) {
      var old =
          element.companyProduct!.product!.oldPrice! * lastOrder.last.amount!;

      final newValue = (old - element.totalPrice!);
      print('-------------------------${newValue}');
      details.add({old: element.totalPrice!});
      saved.value = saved.value + newValue;
    }
    print('-------------------------${saved.value}');
  }
}
