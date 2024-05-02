import '../../../../data/model/user_model.dart';

abstract class IUserRepository {
  Future<bool> regierterUser(UserModel object);
}
