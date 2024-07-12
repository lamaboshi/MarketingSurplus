import '../../../../data/model/evalution.dart';
import '../../../../data/model/rate.dart';

abstract class IRateRepository {
  Future<bool> regierterRate(Rate object, int subId);
  Future<List<Evalution>> getRates(int id);
  Future<bool> deleteRate(int id);
  Future<bool> updateRate(Rate object);
}
