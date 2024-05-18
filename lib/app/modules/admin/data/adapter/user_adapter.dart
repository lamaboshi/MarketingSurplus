import '../../../../data/model/user_model.dart';

abstract class IUsersDataRepository {
  Future<List<UserModel>> getUsers();
  Future<bool> regierterUser(UserModel object);
  Future<bool> deleteUser(int id);
  Future<bool> updateUser(UserModel object);
}
