import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/charity.dart';

import 'adapter/charity_adapter.dart';

class CharityRepository extends ICharityRepository {
  final _dio = Get.find<Dio>();

  @override
  Future<bool> regierterCharity(Charity object) async {
    var data =
        await _dio.post('/api/Charity/AddCharity', data: object.toJson());
    if (data.statusCode == 200) {
      return true;
    } else {
      print(data.statusMessage);
    }
    return false;
  }

  @override
  Future<bool> deleteCharity(int id) async {
    var result = await _dio.delete(
      '/api/Charity/Delete/$id',
    );
    return result.statusCode == 200;
  }

  @override
  Future<List<Charity>> getCharities() async {
    var result = await _dio.get('/api/Charity/GetCharities');
    print(result);
    var list = <Charity>[];
    for (var item in result.data) {
      list.add(Charity.fromJson(item));
    }
    return list;
  }

  @override
  Future<bool> updateCharity(Charity object) async {
    var result =
        await _dio.put('/api/Charity/Put/${object.id}', data: object.toJson());
    return result.statusCode == 200;
  }
}
