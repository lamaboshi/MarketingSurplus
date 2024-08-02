import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/modules/home/controller/home_controller.dart';
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
                    : Obx(
                        () => SingleChildScrollView(
                          child: Column(
                            children: controller.productsOrderCompany
                                .map((element) => getOneCard(element, true))
                                .toList(),
                          ),
                        ),
                      ),
              ),
              SectionWidget(
                flex: 1,
                icon: Icons.label,
                title: 'lastord-title'.tr,
                child: controller.lastProductsOrderCompany.isEmpty
                    ? EmptyData()
                    : SingleChildScrollView(
                        child: Column(
                          children: controller.lastProductsOrderCompany
                              .map((element) => getOneCard(element, false))
                              .toList(),
                        ),
                      ),
              )
            ],
          ));
  }

  Widget getOneCard(OrderProduct element, bool withIcon) {
    element.companyProduct = Get.find<HomeController>()
        .products
        .where((p0) => p0.id == element.companyProductId)
        .first;
    return InkWell(
      onTap: () {
        print(element.toJson());
        Overlayment.show(OverDialog(
            child: OrderDetailsPage(
          orderProduct: element,
        )));
      },
      child: Card(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('ordername-title'.tr),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(element.order!.name ?? ''),
                ],
              ),
              Text(
                element.order!.price != null
                    ? element.order!.price.toString()
                    : '',
                style: TextStyle(fontSize: 16, color: Colors.purple.shade200),
              ),
            ],
          ),
          trailing: withIcon
              ? Column(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.update,
                        color: Colors.orange,
                        size: 35,
                      ),
                      onPressed: () async {
                        await controller.updateOrderStatus(element);
                      },
                    ),
                  ],
                )
              : SizedBox.shrink(),
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
