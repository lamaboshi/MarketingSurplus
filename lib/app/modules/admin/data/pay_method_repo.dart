import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/pay_method.dart';
import 'package:marketing_surplus/app/modules/admin/data/adapter/pay_method_adapter.dart';

class PayMethodRepositry extends IPayMethodRepositry {
  final _dio = Get.find<Dio>();
  @override
  Future<bool> addMethod(PayMethod payMethod) async {
    var result = await _dio.post(
        'https://localhost:7092/api/PayMethod/AddPayMethod',
        data: payMethod.toJson());
    return result.statusCode == 200;
  }

  @override
  Future<bool> deleteMethod(int payMethodId) async {
    var result = await _dio.delete(
      'https://localhost:7092/api/PayMethod/Delete/$payMethodId',
    );
    return result.statusCode == 200;
  }

  @override
  Future<List<PayMethod>> getAllMethod() async {
    var result =
        await _dio.get('https://localhost:7092/api/PayMethod/GetPayMethods');
    print(result);
    var list = <PayMethod>[];
    for (var item in result.data) {
      list.add(PayMethod.fromJson(item));
    }
    return list;
  }

  @override
  Future<bool> updateMethod(PayMethod payMethod) async {
    var result = await _dio.put(
        'https://localhost:7092/api/PayMethod/Put/${payMethod.id}',
        data: payMethod.toJson());
    return result.statusCode == 200;
  }
}
