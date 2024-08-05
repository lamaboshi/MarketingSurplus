import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';

import '../../../data/model/company_product.dart';
import '../../../data/model/save_product.dart';
import 'adapter/company_adapter.dart';

class CompanyRepository extends ICompanyDataRepository {
  final _dio = Get.find<Dio>();
  @override
  Future<bool> regierterComp(Company object) async {
    var data =
        await _dio.post('/api/Company/AddCompany', data: object.toJson());
    if (data.statusCode == 200) {
      return true;
    } else {
      print(data.statusMessage);
    }
    return false;
  }

  @override
  Future<List<Company>> getCompany() async {
    var result = await _dio.get('/api/Company/GetAllCompany');
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
      '/api/Company/Delete/$id',
    );
    return result.statusCode == 200;
  }

  @override
  Future<bool> updateCompany(Company company) async {
    var result = await _dio.put('/api/Company/Put/${company.id}',
        data: company.toJson());
    return result.statusCode == 200;
  }

  @override
  Future<List<CompanyProduct>> getAllCompanyProduct(int companyId) async {
    var result = await _dio.get('/api/Main/GetAllCompanyProduct/$companyId');
    print(result);
    var list = <CompanyProduct>[];
    for (var item in result.data) {
      list.add(CompanyProduct.fromJson(item));
    }
    return list;
  }

  Future<bool> acceptCompany(int id, bool accept) async {
    var result =
        await _dio.post('/api/Company/AcceptCompany/$id?accept=$accept');
    return result.statusCode == 200;
  }

  @override
  Future<bool> addProduct(SaveProduct product) async {
    final auth = Get.find<AuthService>();
    if (auth.getTypeEnum() == Auth.comapny) {
      final id = (auth.getDataFromStorage() as Company).id!;
      product.companyId = id;
      product.product!.id = 0;
      print(product.toJson());
      var data = await _dio.post('/api/Main/AddCompanyProduct',
          data: product.toJson());
      if (data.statusCode == 200) {
        return true;
      } else {
        print(data.statusMessage);
      }
    }

    return false;
  }
}
