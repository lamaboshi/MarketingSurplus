import '../../../../data/model/rate.dart';

abstract class IRateRepository {
  Future<bool> regierterRate(Rate object, int subId);
  Future<List<Rate>> getRates();
  Future<bool> deleteRate(int id);
  Future<bool> updateRate(Rate object);
}
