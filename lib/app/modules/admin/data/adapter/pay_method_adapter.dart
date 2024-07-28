import '../../../../data/model/pay_method.dart';

abstract class IPayMethodRepositry {
  Future<List<CompanyMethods>> getAllMethod(int companyId);
  Future<List<CompanyMethods>> getAllOfMethod();
  Future<bool> addMethod(PayMethod payMethod, int idCompany);
  Future<bool> updateMethod(PayMethod payMethod);
  Future<bool> deleteMethod(int payMethodId);
}
