import '../../../../data/model/charity.dart';

abstract class ICharityRepository {
  Future<bool> regierterCharity(Charity object);
  Future<List<Charity>> getCharities();
  Future<bool> deleteCharity(int id);
  Future<bool> updateCharity(Charity object);
}
