import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_type_model.dart';

import 'adapter/company_type_adapter.dart';

class CompanyTypeRepository extends ICompanyTypeRepository {
  final _dio = Get.find<Dio>();

  @override
  Future<bool> addCompanyType(CompanyTypeModel companyType) async {
    var result = await _dio.post(
        'https://localhost:7092/api/CompanyType/AddCompanyType',
        data: companyType.toJson());
    return result.statusCode == 200;
  }

  @override
  Future<bool> deleteCompanyType(int id) async {
    var result = await _dio.delete(
      'https://localhost:7092/api/CompanyType/Delete/$id',
    );
    return result.statusCode == 200;
  }

  @override
  Future<List<CompanyTypeModel>> getCompanyType() async {
    var result =
        await _dio.get('https://localhost:7092/api/CompanyType/GetCompanyType');
    print(result);
    var list = <CompanyTypeModel>[];
    for (var item in result.data) {
      list.add(CompanyTypeModel.fromJson(item));
    }
    return list;
  }
}
