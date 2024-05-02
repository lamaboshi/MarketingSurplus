import '../../../../data/model/company.dart';

abstract class ICompanyDataRepository {
  Future<List<Company>> getCompany();
}
