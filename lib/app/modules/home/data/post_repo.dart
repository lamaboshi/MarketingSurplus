import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product_dto.dart';
import 'package:marketing_surplus/app/data/model/product.dart';

import 'adapter/post_adapter.dart';

class PostRepository extends IPostRepository {
  final _dio = Get.find<Dio>();
  @override
  Future<List<CompanyProductDto>> getAllPosts(int userId) async {
    var result = await _dio.get('/api/Main/GetAllPosts/$userId');
    print(result);
    var list = <CompanyProductDto>[];
    for (var item in result.data) {
      list.add(CompanyProductDto.fromJson(item));
    }
    return list;
  }

  @override
  Future<List<CompanyProductDto>> getSubscriptionPosts(int userId) async {
    var result = await _dio.get('/api/Main/GetSubscriptionPosts/$userId');
    print(result);
    var list = <CompanyProductDto>[];
    for (var item in result.data) {
      list.add(CompanyProductDto.fromJson(item));
    }
    return list;
  }

  @override
  Future<bool> saveCompanyProduct(
      Product product, int companyId, int amount) async {
    var result = await _dio.post(
        '/api/Main/AddCompanyProduct?CompanyId=$companyId&Amount=$amount',
        data: product.toJson());
    return result.statusCode == 200;
  }
}
