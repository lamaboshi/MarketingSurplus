import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/pay_method.dart';
import 'package:marketing_surplus/app/modules/admin/data/adapter/pay_method_adapter.dart';

class PayMethodRepositry extends IPayMethodRepositry {
  final _dio = Get.find<Dio>();
  @override
  Future<bool> addMethod(PayMethod payMethod, int idCompany) async {
    var result = await _dio.post('/api/PayMethod/AddPayMethod/$idCompany',
        data: payMethod.toJson());
    return result.statusCode == 200;
  }

  @override
  Future<bool> deleteMethod(int payMethodId) async {
    var result = await _dio.delete(
      '/api/PayMethod/Delete/$payMethodId',
    );
    return result.statusCode == 200;
  }

  @override
  Future<List<CompanyMethods>> getAllMethod(int companyId) async {
    var result = await _dio.get('/api/PayMethod/GetPayMethods/$companyId');
    print(result);
    var list = <CompanyMethods>[];
    for (var item in result.data) {
      list.add(CompanyMethods.fromJson(item));
    }
    return list;
  }

  @override
  Future<List<CompanyMethods>> getAllOfMethod() async {
    var result = await _dio.get('/api/PayMethod/GetAllPayMethod');
    print(result);
    var list = <CompanyMethods>[];
    for (var item in result.data) {
      list.add(CompanyMethods.fromJson(item));
    }
    return list;
  }

  @override
  Future<bool> updateMethod(PayMethod payMethod) async {
    var result = await _dio.put('/api/PayMethod/Put/${payMethod.id}',
        data: payMethod.toJson());
    return result.statusCode == 200;
  }
}
