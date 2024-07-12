import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/modules/profile/controller/profile_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/order_service.dart';
import '../../../../shared/widgets/empty_screen.dart';
import '../../bills/view/order_details_page.dart';

class LastOrderUser extends GetView<ProfileController> {
  const LastOrderUser({required this.isLast, super.key});
  final bool isLast;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => isEmptyOrder()
          ? const EmptyOrder()
          : SingleChildScrollView(
              child: Column(
                children: isLast
                    ? controller.orderProducts
                        .where((p0) => p0.bills!.last.orderStatusId == 4)
                        .toList()
                        .map((e) => getWidget(e))
                        .toList()
                    : controller.orderProducts
                        .where((p0) => p0.bills!.last.orderStatusId != 4)
                        .toList()
                        .map((e) => getWidget(e))
                        .toList(),
              ),
            ),
    );
  }

  bool isEmptyOrder() => isLast
      ? controller.orderProducts
          .where((p0) => p0.bills!.last.orderStatusId == 4)
          .toList()
          .isEmpty
      : controller.orderProducts
          .where((p0) => p0.bills!.last.orderStatusId != 4)
          .toList()
          .isEmpty;
  Widget getWidget(OrderProduct element) {
    return InkWell(
      onTap: () {
        Overlayment.show(OverDialog(
            child: OrderDetailsPage(
          orderProduct: element,
        )));
      },
      child: Card(
        child: ListTile(
          title: Row(
            children: [
              Text('ordername-title'.tr),
              const SizedBox(
                width: 5,
              ),
              Text(element.order!.name ?? ''),
            ],
          ),
          trailing: Text(
            element.order!.price != null ? element.order!.price.toString() : '',
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('orderdes-title'.tr),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      element.order!.descripation ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text('orderstat-title'.tr),
                  const SizedBox(
                    width: 5,
                  ),
                  Chip(
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.purple.shade200,
                      label: Text(
                        OrderStutas.values
                            .where((e) =>
                                e.index == element.bills!.last.orderStatusId)
                            .first
                            .name
                            .tr,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
