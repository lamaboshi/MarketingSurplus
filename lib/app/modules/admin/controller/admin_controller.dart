import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';
import 'package:marketing_surplus/app/data/model/order_type.dart';
import 'package:marketing_surplus/app/data/model/pay_method.dart';
import 'package:marketing_surplus/app/data/model/user_model.dart';
import 'package:marketing_surplus/app/modules/admin/data/company_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/order_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/order_type_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/pay_method_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/rate_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/user_repo.dart';
import 'package:marketing_surplus/app/modules/admin/view/company_type_widget.dart';
import 'package:overlayment/overlayment.dart';

import '../../../data/model/company_type_model.dart';
import '../../../data/model/rate.dart';
import '../data/company_type_repo.dart';
import '../view/company_widget.dart';
import '../view/order_type_widget.dart';
import '../view/order_widget.dart';
import '../view/pay_method_widget.dart';
import '../view/rate_widget.dart';
import '../view/user_widget.dart';

enum Resource {
  companyType,
  users,
  company,
  orders,
  asso,
  donation,
  payMethod,
  orderType,
  rate,
  non
}

class AdminController extends GetxController {
  final listTabs = [
    'Manage Comapny Type',
    'Manage App Users',
    'Manage App Company',
    'Show All Orders In App',
    'Association requests',
    'Donation requests',
    'Manage Pay Methods',
    'Manage Order Type',
    'All Rates'
  ];
  final orderColumn = [
    'ID',
    'Name',
    'Description',
    'Amount',
    'Price',
    'Is Delivery',
    'Pay Method',
    'User ID'
  ];
  final companyColumn = [
    'ID',
    'Name',
    'Phone',
    'Email',
    'Address',
    'TelePhone',
    'LicenseNumber',
    'CompanyType ID'
  ];
  final userColumn = [
    'ID',
    'Name',
    'Phone',
    'Email',
    'Address',
  ];
  final typeColumn = ['ID', 'Type Name', 'Description'];
  final methodColumn = ['ID', 'Name'];
  final orderTypeColumn = ['ID', 'Name'];
  final rateColumn = ['ID', 'Rate Number', 'Description'];
  final typeRsource = Resource.non.obs;
  final isTypeRsource = false.obs;
  final companyTypes = <CompanyTypeModel>[].obs;
  final typeRepo = CompanyTypeRepository();
  final companys = <Company>[].obs;
  final users = <UserModel>[].obs;
  final method = <PayMethod>[].obs;
  final rates = <Rate>[].obs;
  final orderTypes = <OrderType>[].obs;
  final orders = <OrderModel>[].obs;
  final addCompanyType = CompanyTypeModel().obs;
  final userRepo = UsersDataRepository();
  final orderRepo = OrderDataRepository();
  final payRepo = PayMethodRepositry();
  final rateRepo = RateRepository();
  final orderTypeRepo = OrderTypeRepositry();
  final companyRepo = CompanyRepository();
  final type = CompanyTypeModel().obs;
  final pay = PayMethod().obs;
  final orderType = OrderType().obs;

  @override
  void onInit() {
    super.onInit();
    getAllCompanyType();
    getAllCompany();
    getAllUsers();
    getAllOrders();
    getAllMethod();
    getAllOrderType();
    getRates();
  }

  Resource setResourceEnum(index) {
    switch (index) {
      case 0:
        return Resource.companyType;
      case 1:
        return Resource.users;
      case 2:
        return Resource.company;
      case 3:
        return Resource.orders;
      case 4:
        return Resource.asso;
      case 5:
        return Resource.donation;
      case 6:
        return Resource.payMethod;
      case 7:
        return Resource.orderType;
      case 8:
        return Resource.rate;
      default:
        return Resource.non;
    }
  }

  Widget getTypeResource() {
    switch (typeRsource.value) {
      case Resource.companyType:
        return const CompanyTypeWidget();
      case Resource.company:
        return const CompanyWidget();
      case Resource.users:
        return const UserWidget();
      case Resource.orders:
        return OrderWidget();
      case Resource.payMethod:
        return const PayMethodWidget();
      case Resource.orderType:
        return const OrderTypeWidget();
      case Resource.rate:
        return const RateWidget();
      default:
        return const SizedBox();
    }
  }

  Future<void> getAllCompanyType() async {
    var data = await typeRepo.getCompanyType();
    companyTypes.assignAll(data);
  }

  Future<void> getAllMethod() async {
    var data = await payRepo.getAllMethod();
    method.assignAll(data);
  }

  Future<void> getRates() async {
    var data = await rateRepo.getRates();
    rates.assignAll(data);
  }

  Future<void> getAllOrderType() async {
    var data = await orderTypeRepo.getAllOrderType();
    orderTypes.assignAll(data);
  }

  Future<void> getAllCompany() async {
    var data = await companyRepo.getCompany();
    companys.assignAll(data);
  }

  Future<void> getAllUsers() async {
    var data = await userRepo.getUsers();
    users.assignAll(data);
  }

  Future<void> getAllOrders() async {
    var data = await orderRepo.getOrders();
    orders.assignAll(data);
  }

  Future<void> deladdCompanyTypelement(
      CompanyTypeModel companyTypeModel) async {
    var res = await typeRepo.deleteCompanyType(companyTypeModel.id!);
    if (res) {
      companyTypes.clear();
      getAllCompanyType();
    }
  }

  Future<void> addCompanyTypeModelelement(
      CompanyTypeModel companyTypeModel) async {
    var res = await typeRepo.addCompanyType(companyTypeModel);
    if (res) {
      Overlayment.dismissLast();
      companyTypes.clear();
      getAllCompanyType();
      Get.back();
    }
  }

  Future<void> updateCompanyType() async {
    final result = await typeRepo.updateCompanyType(type.value);
    if (result) {
      type.value = CompanyTypeModel();
      Overlayment.dismissLast();
      getAllCompanyType();
      Get.back();
    }
  }

  Future<void> addMethod() async {
    final result = await payRepo.addMethod(pay.value);
    if (result) {
      pay.value = PayMethod();
      Overlayment.dismissLast();
      method.clear();
      await getAllMethod();
    }
  }

  Future<void> deleteMethod(int id) async {
    final result = await payRepo.deleteMethod(id);
    if (result) {
      method.clear();
      await getAllMethod();
    }
  }

  Future<void> updateMethod() async {
    final result = await payRepo.updateMethod(pay.value);
    if (result) {
      pay.value = PayMethod();
      Overlayment.dismissLast();
      method.clear();
      await getAllMethod();
    }
  }

  Future<void> addOrderType() async {
    final result = await orderTypeRepo.addOrderType(orderType.value);
    if (result) {
      orderType.value = OrderType();
      Overlayment.dismissLast();
      orderTypes.clear();
      await getAllOrderType();
    }
  }

  Future<void> deleteOrderType(int id) async {
    final result = await orderTypeRepo.deleteOrderType(id);
    if (result) {
      orderTypes.clear();
      await getAllOrderType();
    }
  }

  Future<void> updateOrderType() async {
    final result = await orderTypeRepo.updateOrderType(orderType.value);
    if (result) {
      orderType.value = OrderType();
      Overlayment.dismissLast();
      orderTypes.clear();
      await getAllOrderType();
    }
  }
}
