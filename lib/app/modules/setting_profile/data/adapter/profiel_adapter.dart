import 'package:marketing_surplus/app/data/model/company_product_dto.dart';
import 'package:marketing_surplus/app/data/model/company_type_model.dart';

import '../../../../data/model/subscription.dart';
import '../model_data.dart';

abstract class IProfailRepository {
  Future<List<CompanyTypeModel>> getCompanyType(int idCompany);
  Future<List<CompanyProductDto>> getCompPost(int idCompany);
  Future<int> getCountFollowCompany(String email);
  Future<List<ModelData>> getAllFollowCompany(String email);
  Future<bool> deletPost(int idPost);
  Future<bool> updatePost(int idPost, CompanyProductDto post);
  ////
  Future<bool> addSubscription(Subscription subscription);
  Future<bool> deleteuserCompany(int idsubscription);
  Future<List<Subscription>> getuserCompany(int userId);
  Future<List<Subscription>> getCompanySubcripation(int comanyId);
  Future<Subscription> getSubcripation(int userId, int comanyId);
}
