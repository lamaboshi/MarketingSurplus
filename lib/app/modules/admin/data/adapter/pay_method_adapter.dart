import '../../../../data/model/pay_method.dart';

abstract class IPayMethodRepositry {
  Future<List<PayMethod>> getAllMethod();
  Future<bool> addMethod(PayMethod payMethod);
  Future<bool> updateMethod(PayMethod payMethod);
  Future<bool> deleteMethod(int payMethodId);
}
