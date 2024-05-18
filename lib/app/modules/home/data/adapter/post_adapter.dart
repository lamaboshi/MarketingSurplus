import '../../../../data/model/company_product_dto.dart';

abstract class IPostRepository {
  Future<List<CompanyProductDto>> getAllPosts(int userId);
  Future<List<CompanyProductDto>> getSubscriptionPosts(int userId);
}
