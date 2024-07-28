import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';
import 'package:marketing_surplus/shared/service/order_service.dart';
import 'package:overlayment/overlayment.dart';

class OrderDetailsPage extends GetView<BillsController> {
  final OrderProduct? orderProduct;
  OrderDetailsPage({this.orderProduct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'order-details'.tr,
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade200),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Overlayment.dismissLast();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.purple.shade200,
                    ))
              ],
            ),
            if (controller.auth.getTypeEnum() == Auth.comapny)
              getRow('user-type', orderProduct!.order!.userId.toString()),
            getRow('ordername-title', orderProduct!.order!.name ?? ''),
            getRow('orderdes-title', orderProduct!.order!.descripation ?? ''),
            if (orderProduct!.companyProduct!.product != null)
              getRow('namepro-title',
                  orderProduct!.companyProduct!.product!.name ?? ''),
            if (orderProduct!.companyProduct!.product != null)
              getRow('despro-title',
                  orderProduct!.companyProduct!.product!.descripation ?? ''),
            if (orderProduct!.companyProduct!.product != null)
              getRow('expda-title',
                  orderProduct!.companyProduct!.product!.expiration.toString()),
            if (orderProduct!.companyProduct!.product != null)
              getRow('creatda-title',
                  orderProduct!.companyProduct!.product!.dateTime.toString()),
            if (orderProduct!.companyProduct!.product != null)
              getRow('new-price',
                  orderProduct!.companyProduct!.product!.newPrice.toString()),
            if (orderProduct!.companyProduct!.product != null)
              getRow('oldpri-title',
                  orderProduct!.companyProduct!.product!.oldPrice.toString()),
            getRow('amoutth-title',
                orderProduct!.companyProduct!.amount.toString()),
            if (orderProduct!.companyProduct!.company != null)
              getRow('cmp-name',
                  orderProduct!.companyProduct!.company!.name ?? ''),
            if (orderProduct!.companyProduct!.company != null)
              getRow('cmp-email',
                  orderProduct!.companyProduct!.company!.email ?? ''),
            if (orderProduct!.companyProduct!.company != null)
              getRow('cmp-phone',
                  orderProduct!.companyProduct!.company!.phone ?? ''),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('all-status'.tr),
                )),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: orderProduct!.bills!
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Chip(
                                      label: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      OrderStutas.values[e.orderStatusId!].name,
                                      style: TextStyle(
                                          color: Colors.purple.shade200),
                                    ),
                                  )),
                                ))
                            .toList(),
                      ),
                    ))
              ],
            ),
            getRow('amount-title', orderProduct!.amount.toString()),
            getRow('price-title', orderProduct!.totalPrice.toString()),
            getRow('isdel-title', orderProduct!.order!.isDelivery!.toString()),
          ],
        ),
      ),
    );
  }

  Widget getRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title.tr),
        )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: Get.width - 200,
              child: Row(
                children: [
                  Flexible(child: Text(value.tr)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
