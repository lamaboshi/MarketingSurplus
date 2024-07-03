import 'package:marketing_surplus/app/data/model/product.dart';

import '../../../../data/model/company_product_dto.dart';

abstract class IPostRepository {
  Future<List<CompanyProductDto>> getAllPosts(int userId);
  Future<List<CompanyProductDto>> getSubscriptionPosts(int userId);
  Future<bool> saveCompanyProduct(Product product, int companyId, int amount);
}
