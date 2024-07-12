import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/modules/menu/controller/menu_controller.dart'
    as co;
import 'package:marketing_surplus/shared/widgets/empty_screen.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/order_service.dart';
import '../../../../shared/widgets/section_widget.dart';
import '../../bills/view/order_details_page.dart';

class MenuCompanyPage extends GetView<co.MenuController> {
  const MenuCompanyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              SectionWidget(
                flex: 1,
                icon: Icons.new_label,
                title: 'order-title'.tr,
                child: controller.productsOrderCompany.isEmpty
                    ? EmptyData()
                    : Column(
                        children: controller.productsOrderCompany
                            .map((element) => getOneCard(element))
                            .toList(),
                      ),
              ),
              SectionWidget(
                flex: 1,
                icon: Icons.label,
                title: 'lastord-title'.tr,
                child: controller.lastProductsOrderCompany.isEmpty
                    ? EmptyData()
                    : Column(
                        children: controller.lastProductsOrderCompany
                            .map((element) => getOneCard(element))
                            .toList(),
                      ),
              )
            ],
          ));
  }

  Widget getOneCard(OrderProduct element) {
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
              const Text('Order Name :'),
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
                  const Text('Order Descripation :'),
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
                  const Text('Order Stutes :'),
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
                            .name,
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
