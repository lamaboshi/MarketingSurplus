import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_type_model.dart';

import 'adapter/company_type_adapter.dart';

class CompanyTypeRepository extends ICompanyTypeRepository {
  final _dio = Get.find<Dio>();

  @override
  Future<bool> addCompanyType(CompanyTypeModel companyType) async {
    var result = await _dio.post('/api/CompanyType/AddCompanyType',
        data: companyType.toJson());
    return result.statusCode == 200;
  }

  @override
  Future<bool> deleteCompanyType(int id) async {
    var result = await _dio.delete(
      '/api/CompanyType/Delete/$id',
    );
    return result.statusCode == 200;
  }

  @override
  Future<List<CompanyTypeModel>> getCompanyType() async {
    var list = <CompanyTypeModel>[];

    try {
      var response = await _dio.get('/api/CompanyType/GetCompanyType');

      if (response.statusCode == 200) {
        for (var item in response.data) {
          list.add(CompanyTypeModel.fromJson(item));
        }
        return list;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        // Server responded with a status code other than 2xx
        print('Error response status: ${e.response?.statusCode}');
        print('Error response data: ${e.response?.data}');
      } else {
        // Error while setting up the request or during the request
        print('Error message: ${e.message}');
        print('Error type: ${e.type}');
      }
    } catch (e) {
      // Other types of errors
      print('Unexpected error: $e');
    }
    return [];
  }

  @override
  Future<bool> updateCompanyType(CompanyTypeModel companyType) async {
    var result = await _dio.put('/api/CompanyType/Put/${companyType.id}',
        data: companyType.toJson());
    return result.statusCode == 200;
  }
}
