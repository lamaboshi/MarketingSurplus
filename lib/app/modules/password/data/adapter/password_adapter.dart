import '../../model/rest_password.dart';

abstract class IPasswordRepository {
  Future<bool> resetPassComp(int idCompany, String newPassword);
  Future<bool> resetPassUser(int idUser, String newPassword);
  Future<RestPassword?> getEmail(String email);
}
