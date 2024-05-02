import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company.dart';

import 'adapter/company_adapter.dart';

class CompanyRepository extends ICompanyDataRepository {
  final _dio = Get.find<Dio>();

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
}
