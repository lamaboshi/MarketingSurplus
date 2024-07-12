import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/rate.dart';

import '../../../data/model/evalution.dart';
import 'adapter/rate_adapter.dart';

class RateRepository extends IRateRepository {
  final _dio = Get.find<Dio>();

  @override
  Future<bool> deleteRate(int id) async {
    var result = await _dio.delete(
      '/api/Rate/Delete/$id',
    );
    return result.statusCode == 200;
  }

  @override
  Future<List<Evalution>> getRates(int id) async {
    try {
      var result = await _dio.get('/api/Rate/GetRates/$id');
      print(result);
      var list = <Evalution>[];
      for (var item in result.data) {
        list.add(Evalution.fromJson(item));
      }
      return list;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> regierterRate(Rate object, int subId) async {
    print(object.toJson());
    print(subId);
    var result = await _dio.post('/api/Rate/AddRate?subId=$subId',
        data: object.toJson());
    return result.statusCode == 200;
  }

  @override
  Future<bool> updateRate(Rate object) async {
    var result =
        await _dio.put('/api/Rate/Put/${object.id}', data: object.toJson());
    return result.statusCode == 200;
  }
}
