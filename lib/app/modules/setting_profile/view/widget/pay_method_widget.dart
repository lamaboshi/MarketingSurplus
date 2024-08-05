import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:overlayment/overlayment.dart';

import '../../../../../shared/service/auth_service.dart';
import '../../../../../shared/widgets/textfield_widget.dart';
import '../../../admin/data/pay_method_repo.dart';
import '../../controller/setting_profile_controller.dart';

class PayMethodView extends GetView<SettingProfileController> {
  const PayMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getPayMethod();
    return controller.auth.getTypeEnum() == Auth.user
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'account-value'.tr,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() => Text(
                      controller.account.value.toString(),
                      style: TextStyle(
                          color: Colors.purple.shade200, fontSize: 21),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Overlayment.show(OverDialog(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'deposit-process'.tr,
                                  style: TextStyle(
                                      color: Colors.purple.shade200,
                                      fontSize: 21),
                                ),
                              ),
                              Text(
                                'dep-title'.tr,
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextFieldWidget(
                                icon: Icons.payment,
                                onChanged: (value) {
                                  controller.account.value =
                                      double.parse(value);
                                },
                                textInputType: TextInputType.number,
                                label: 'amount-title'.tr,
                              ),
                              TextFieldWidget(
                                icon: Icons.payment,
                                onChanged: (value) {},
                                textInputType: TextInputType.emailAddress,
                                label: 'bank-num'.tr,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      controller.auth.stroge.saveData(
                                          'account', controller.account.value);
                                      controller.getAmount();
                                      Overlayment.dismissLast();
                                    },
                                    child: Text('done'.tr)),
                              )
                            ],
                          )));
                        },
                        child: Text('deposit-process'.tr))
                  ],
                ),
              )
            ],
          )
        : Obx(() => controller.pays.isEmpty
            ? Text('nodat-title'.tr)
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'paymeth-title'.tr,
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.purple.shade200,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        controller.auth.getTypeEnum() == Auth.comapny
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Overlayment.show(
                                      OverDialog(
                                        width: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'addpay-title'.tr,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors
                                                          .purple.shade200),
                                                ),
                                              ),
                                              Wrap(
                                                children: listSug
                                                    .map((e) => InkWell(
                                                        onTap: () {
                                                          controller.pay.value
                                                              .name = e;
                                                        },
                                                        child: Chip(
                                                            label: Text(e))))
                                                    .toList(),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Obx(
                                                    () => TextFieldWidget(
                                                      value: controller
                                                              .pay.value.name ??
                                                          '',
                                                      onChanged: (value) {
                                                        controller.pay.value
                                                            .name = value;
                                                      },
                                                      textInputType:
                                                          TextInputType.text,
                                                      label: 'namepay-title'.tr,
                                                    ),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    await controller
                                                        .addMethod();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors
                                                          .purple.shade200,
                                                      shape:
                                                          const StadiumBorder()),
                                                  child: SizedBox(
                                                    width: 150,
                                                    height: 30,
                                                    child: Center(
                                                      child: Text(
                                                        'save-title'.tr,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 19),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'addd-title'.tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.purple.shade200),
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                          children: controller.pays
                              .map((element) => ListTile(
                                    leading: const Icon(
                                      Icons.payment,
                                      color: Colors.cyan,
                                    ),
                                    title: Text(element.payMethod!.name ?? ""),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        await PayMethodRepositry()
                                            .deleteMethod(element.id!);
                                        await controller.getPayMethod();
                                        Overlayment.dismissLast();
                                      },
                                    ),
                                  ))
                              .toList()),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ));
  }

  List<String> get listSug => ['PayPal', 'Credit Card', 'Cash Pay'];
}
