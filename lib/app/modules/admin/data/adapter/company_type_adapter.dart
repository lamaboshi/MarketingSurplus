import '../../../../data/model/company_type_model.dart';

abstract class ICompanyTypeRepository {
  Future<List<CompanyTypeModel>> getCompanyType();
  Future<bool> deleteCompanyType(int id);
  Future<bool> addCompanyType(CompanyTypeModel companyType);
}
