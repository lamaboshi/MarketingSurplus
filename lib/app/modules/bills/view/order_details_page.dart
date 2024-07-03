import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';
import 'package:marketing_surplus/shared/service/order_service.dart';
import 'package:overlayment/overlayment.dart';

class OrderDetailsPage extends GetView<BillsController> {
  final OrderProduct? orderProduct;
  OrderDetailsPage({this.orderProduct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Order Details',
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
          getRow('ordername-title', orderProduct!.order!.name ?? ''),
          getRow('orderdes-title', orderProduct!.order!.descripation ?? ''),
          getRow('namepro-title',
              orderProduct!.companyProduct!.product!.name ?? ''),
          getRow('despro-title',
              orderProduct!.companyProduct!.product!.descripation ?? ''),
          getRow('Product Expiration Date :',
              orderProduct!.companyProduct!.product!.expiration.toString()),
          getRow('Product Create Date :',
              orderProduct!.companyProduct!.product!.dateTime.toString()),
          getRow('Product New Price :',
              orderProduct!.companyProduct!.product!.newPrice.toString()),
          getRow('Product Old Price :',
              orderProduct!.companyProduct!.product!.oldPrice.toString()),
          getRow('Product Total Amount :',
              orderProduct!.companyProduct!.amount.toString()),
          getRow('Company Name :',
              orderProduct!.companyProduct!.company!.name ?? ''),
          getRow('Company Email :',
              orderProduct!.companyProduct!.company!.email ?? ''),
          getRow('Company Phone :',
              orderProduct!.companyProduct!.company!.phone ?? ''),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Bills :'),
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
          getRow('Take Amount :', orderProduct!.amount.toString()),
          getRow('Total Price :', orderProduct!.totalPrice.toString()),
          getRow('is Delivery :', orderProduct!.order!.isDelivery!.toString()),
        ],
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
          child: Text(title),
        )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: Get.width - 200,
              child: Row(
                children: [
                  Flexible(child: Text(value)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
