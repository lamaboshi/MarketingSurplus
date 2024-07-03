import '../../../../data/model/company.dart';
import '../../../../data/model/company_product.dart';
import '../../../../data/model/save_product.dart';

abstract class ICompanyDataRepository {
  Future<List<Company>> getCompany();
  Future<bool> regierterComp(Company object);
  Future<bool> deleteCompany(int id);
  Future<bool> updateCompany(Company company);
  Future<bool> addProduct(SaveProduct product);
  Future<List<CompanyProduct>> getAllCompanyProduct(int companyId);
}
