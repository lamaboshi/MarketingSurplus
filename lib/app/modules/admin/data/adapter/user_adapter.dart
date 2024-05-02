import '../../../../data/model/user_model.dart';

abstract class IUsersDataRepository {
  Future<List<UserModel>> getUsers();
}
