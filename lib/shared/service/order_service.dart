import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/charity.dart';
import 'package:marketing_surplus/app/data/model/donation.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';
import 'package:marketing_surplus/app/data/model/product.dart';

import '../../api/storge/storge_service.dart';
import '../../app/data/model/company.dart';
import '../../app/data/model/order_Product.dart';
import '../../app/data/model/order_type.dart';
import '../../app/data/model/product_donation.dart';
import '../../app/data/model/user_model.dart';
import 'auth_service.dart';

enum OrderStutas { none, waitingAccepte, accepted, preparation, done }

class OrderService {
  final _dio = Get.find<Dio>();
  final stroge = Get.find<StorageService>();
  final auth = Get.find<AuthService>();
  final orderKay = 'order';
  final orderTypeKay = 'orderType';
  bool inOrder() => stroge.containsKey(orderKay);
  bool inorderType() => stroge.containsKey(orderTypeKay);
  OrderStutas? getOrderStutas() {
    if (stroge.getData(orderTypeKay) != null) {
      final name = jsonDecode(stroge.getData(orderTypeKay)!).toString();
      return OrderStutas.values.where((element) => element.name == name).first;
    }
    return null;
  }

  OrderModel? getOrderFromStorage() {
    if (stroge.containsKey(orderKay)) {
      var data = jsonDecode(stroge.getData(orderKay)!) as dynamic;
      return OrderModel.fromJson(data as Map<String, dynamic>);
    }
    return null;
  }

  Future<bool> saveOrder(
      OrderModel order, List<OrderProduct> orderProduct) async {
    if (auth.getTypeEnum() == Auth.user) {
      final userId = (auth.getDataFromStorage() as UserModel).id!;
      order.userId = userId;
    }
    print(order.toJson());
    var data = await _dio.post('/api/Main/SaveOrder', data: order.toJson());
    if (data.statusCode == 200) {
      print('****************** add order');
      final orderId = int.parse(data.data.toString());
//ToAddAll Products
      for (var element in orderProduct) {
        element.orderId = orderId;
        print(element.toJson());
        await _dio.post('/api/Main/SaveOrderProduct', data: element.toJson());
        print('****************** add Product');
      }

      //TOSaveOrder
      final order = await getOrder(orderId);
      stroge.saveData(
          orderTypeKay, jsonEncode(OrderStutas.waitingAccepte.name));
      stroge.saveData(orderKay, jsonEncode(order.toJson()));
      const key = 'basket-Item';
      stroge.deleteDataByKey(key);

      return true;
    } else {
      print(data.statusMessage);
    }
    return false;
  }

  Future<bool> saveDonation(
      Donation donation, List<ProductDonation> product) async {
    if (auth.getTypeEnum() == Auth.charity) {
      final charityId = (auth.getDataFromStorage() as Charity).id!;
      donation.charityId = charityId;
    }
    print(donation.toJson());

    var data =
        await _dio.post('/api/Donation/SaveDonation', data: donation.toJson());
    if (data.statusCode == 200) {
      print('****************** add donation');
      final donationId = int.parse(data.data.toString());
//ToAddAll Products
      for (var element in product) {
        element.donationId = donationId;
        print(element.toJson());
        await _dio.post('/api/Donation/SaveProductDonation',
            data: element.toJson());
        print('****************** add donation Product');
      }
      const key = 'basket-Item';
      stroge.deleteDataByKey(key);
      return true;
    } else {
      print(data.statusMessage);
    }
    return false;
  }

  Future<List<ProductDonation>> getAllDonation({int? idCh}) async {
    var dataId = idCh;
    if (dataId == null) {
      var id = (auth.getDataFromStorage() as Charity).id;
      dataId = id;
    }

    var data = await _dio.get('/api/Donation/GetAllOrder/$dataId');
    print(data);
    var list = <ProductDonation>[];
    for (var item in data.data) {
      list.add(ProductDonation.fromJson(item));
    }
    return list;
  }

  Future<List<Company>> getAllCompanyForCharity() async {
    var id = (auth.getDataFromStorage() as Charity).id;
    var data = await _dio.get('/api/Donation/GetAllCompanyForThis/$id');

    var list = <Company>[];
    for (var item in data.data) {
      list.add(Company.fromJson(item));
    }
    return list;
  }

  Future<List<Donation>> getAllDonationForCompany(int idCompany) async {
    var data =
        await _dio.get('/api/Donation/GetAllDonationForCompany/$idCompany');

    var list = <Donation>[];
    for (var item in data.data) {
      list.add(Donation.fromJson(item));
    }
    return list;
  }

  Future<OrderModel> getOrder(int id) async {
    var result = await _dio.get('/api/Order/Get/$id');
    print(result);
    return OrderModel.fromJson(result.data as Map<String, dynamic>);
  }

  Future<Donation> getDonation(int id) async {
    var result = await _dio.get('/api/Donation/GetDonation/$id');
    print(result);
    return Donation.fromJson(result.data as Map<String, dynamic>);
  }

  Future<List<OrderType>> getOrderType() async {
    var data = await _dio.get('/api/OrderType/GetOrderTypes');

    var list = <OrderType>[];
    for (var item in data.data) {
      list.add(OrderType.fromJson(item));
    }
    return list;
  }

  Future<List<OrderProduct>> getOrderDetailsForCompany() async {
    var id = (auth.getDataFromStorage() as Company).id;

    var data = await _dio.get('/api/Main/GetOrderDetailsForCompany/$id');
    print(data);
    var list = <OrderProduct>[];
    for (var item in data.data) {
      list.add(OrderProduct.fromJson(item));
    }
    return list;
  }

  Future<bool> updateStatusOrder(int orderId, int status) async {
    var result =
        await _dio.post('/api/Main/UpdateStutasOrder/$orderId', data: status);
    print('----------------Done Update Status--------------------------');
    return result.statusCode == 200;
  }

  Future<bool> updateStatusDonation(
      int idDonation, bool status, bool isCencal, bool isCompany) async {
    var result = await _dio.post(
        '/api/Donation/UpdateStutasDonation/$idDonation',
        data: {"status": status, "isCompany": isCompany, "isCencal": isCencal});
    print('----------------Done Update Status--------------------------');
    return result.statusCode == 200;
  }

  Future<bool> deleteProduct(int id) async {
    var result = await _dio.delete(
      '/api/Main/Delete/$id',
    );
    return result.statusCode == 200;
  }

  Future<bool> updateProduct(Product product) async {
    var result =
        await _dio.put('/api/Main/Put/${product.id}', data: product.toJson());
    return result.statusCode == 200;
  }
}
