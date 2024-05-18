import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company.dart';

import '../../../data/model/company_product.dart';
import 'adapter/company_adapter.dart';

class CompanyRepository extends ICompanyDataRepository {
  final _dio = Get.find<Dio>();
  @override
  Future<bool> regierterComp(Company object) async {
    var data = await _dio.post('https://localhost:7092/api/Company/AddCompany',
        data: object.toJson());
    if (data.statusCode == 200) {
      return true;
    } else {
      print(data.statusMessage);
    }
    return false;
  }

  @override
  Future<List<Company>> getCompany() async {
    var result =
        await _dio.get('https://localhost:7092/api/Company/GetAllCompany');
    print(result);
    var list = <Company>[];
    for (var item in result.data) {
      list.add(Company.fromJson(item));
    }
    return list;
  }

  @override
  Future<bool> deleteCompany(int id) async {
    var result = await _dio.delete(
      'https://localhost:7092/api/Company/Delete/$id',
    );
    return result.statusCode == 200;
  }

  @override
  Future<bool> updateCompany(Company company) async {
    var result = await _dio.put(
        'https://localhost:7092/api/Company/Put/${company.id}',
        data: company.toJson());
    return result.statusCode == 200;
  }

  @override
  Future<List<CompanyProduct>> getAllCompanyProduct(int companyId) async {
    var result = await _dio
        .get('https://localhost:7092/api/Main/GetAllCompanyProduct/$companyId');
    print(result);
    var list = <CompanyProduct>[];
    for (var item in result.data) {
      list.add(CompanyProduct.fromJson(item));
    }
    return list;
  }
}
