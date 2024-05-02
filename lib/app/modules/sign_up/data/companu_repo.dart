import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/model/company.dart';
import 'adapter/company_adapter.dart';

class CompanyRepository extends ICompanyRepository {
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
}
