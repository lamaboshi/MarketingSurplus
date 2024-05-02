import '../../../../data/model/company.dart';

abstract class ICompanyRepository {
  Future<bool> regierterComp(Company object);
}
