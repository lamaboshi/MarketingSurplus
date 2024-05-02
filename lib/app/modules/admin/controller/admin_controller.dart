import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';
import 'package:marketing_surplus/app/data/model/user_model.dart';
import 'package:marketing_surplus/app/modules/admin/data/company_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/order_repo.dart';
import 'package:marketing_surplus/app/modules/admin/data/user_repo.dart';
import 'package:marketing_surplus/app/modules/admin/view/company_type_widget.dart';

import '../../../data/model/company_type_model.dart';
import '../data/company_type_repo.dart';
import '../view/company_widget.dart';
import '../view/order_widget.dart';
import '../view/user_widget.dart';

enum Resource { companyType, users, company, orders, asso, donation, non }

class AdminController extends GetxController {
  final listTabs = [
    'Manage Comapny Type',
    'Manage App Users',
    'Manage App Company',
    'Show All Orders In App',
    'Association requests',
    'Donation requests'
  ];
  final typeRsource = Resource.non.obs;
  final isTypeRsource = false.obs;
  final companyTypes = <CompanyTypeModel>[].obs;
  final typeRepo = CompanyTypeRepository();
  final companys = <Company>[].obs;
  final users = <UserModel>[].obs;
  final orders = <OrderModel>[].obs;
  final addCompanyType = CompanyTypeModel().obs;
  final userRepo = UsersDataRepository();
  final orderRepo = OrderDataRepository();
  final companyRepo = CompanyRepository();
  final type = CompanyTypeModel().obs;
  @override
  void onInit() {
    super.onInit();
    getAllCompanyType();
    getAllCompany();
    getAllUsers();
    getAllOrders();
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
        return const OrderWidget();
      default:
        return const SizedBox();
    }
  }

  Future<void> getAllCompanyType() async {
    var data = await typeRepo.getCompanyType();
    companyTypes.assignAll(data);
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
      getAllCompanyType();
    }
  }

  Future<void> addCompanyTypeModelelement(
      CompanyTypeModel companyTypeModel) async {
    var res = await typeRepo.addCompanyType(companyTypeModel);
    if (res) {
      getAllCompanyType();
      Get.back();
    }
  }
}
