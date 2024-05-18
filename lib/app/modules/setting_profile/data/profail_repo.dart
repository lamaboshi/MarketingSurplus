import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/model/company_product_dto.dart';
import '../../../data/model/company_type_model.dart';
import '../../../data/model/subscription.dart';
import 'adapter/profiel_adapter.dart';
import 'model_data.dart';

class ProfailRepository extends IProfailRepository {
  final _dio = Get.find<Dio>();
  @override
  Future<List<CompanyTypeModel>> getCompanyType(int idCompany) async {
    var result =
        await _dio.get('https://localhost:7192/api/CompanyContent/$idCompany');
    print(result);
    var list = <CompanyTypeModel>[];
    if (result.statusCode == 200) {
      for (var item in result.data) {
        list.add(CompanyTypeModel.fromJson(item));
      }
    }

    return list;
  }

  @override
  Future<List<CompanyProductDto>> getCompPost(int idCompany) async {
    var result = await _dio
        .get('https://localhost:7192/api/Company/GetAllPosts/$idCompany');

    var list = <CompanyProductDto>[];
    if (result.statusCode == 200) {
      for (var item in result.data) {
        list.add(CompanyProductDto.fromJson(item));
      }
    }
    print(
        '--------------------------------------------------------Get Post Company Done-------------------------------');
    return list;
  }

  @override
  Future<List<ModelData>> getAllFollowCompany(String email) async {
    var result = await _dio.get(
        'https://localhost:7192/api/Company/GetFollowers',
        queryParameters: {'email': email});
    var list = <ModelData>[];
    if (result.statusCode == 200) {
      for (var item in result.data) {
        list.add(ModelData.fromJson(item));
      }
    }
    print(
        '--------------------------------------------------------Get getAllFollowCompany Done-------------------------------');
    return list;
  }

  @override
  Future<int> getCountFollowCompany(String email) async {
    var result = await _dio.get(
        'https://localhost:7192/api/Company/GetFollowersCount',
        queryParameters: {'email': email});
    print(
        '--------------------------------------------------------Get getCountFollowCompany Done-------------------------------');
    return result.data;
  }

  @override
  Future<bool> deletPost(int idPost) async {
    var result = await _dio.delete(
      'https://localhost:7192/api/Post/$idPost',
    );
    return result.statusCode == 200;
  }

  @override
  Future<bool> updatePost(int idPost, CompanyProductDto post) async {
    var result = await _dio.put('https://localhost:7192/api/Post/$idPost',
        data: post.toJson());
    return result.statusCode == 200;
  }

  @override
  Future<bool> addSubscription(Subscription subscription) async {
    var result = await _dio.post(
      'https://localhost:7092/api/Subscription/AddSubscription',
      data: subscription.toJson(),
    );
    return result.statusCode == 200;
  }

  @override
  Future<List<Subscription>> getuserCompany(int userId) async {
    var result = await _dio.get(
        'https://localhost:7092/api/Subscription/GetSubscriptiones',
        queryParameters: {'userId': userId});
    print(
        '-------------------------------- GetSubscriptiones ------------------------------');

    var list = <Subscription>[];
    if (result.statusCode == 200) {
      for (var item in result.data) {
        list.add(Subscription.fromJson(item));
      }
    }

    return list;
  }

  @override
  Future<bool> deleteuserCompany(int id) async {
    var result =
        await _dio.delete('https://localhost:7092/api/Subscription/Delete/$id');
    return result.statusCode == 200;
  }

  @override
  Future<List<Subscription>> getCompanySubcripation(int comanyId) async {
    var result = await _dio.get(
        'https://localhost:7092/api/Subscription/GetCompanySubscription',
        queryParameters: {'companyId': comanyId});
    print(
        '-------------------------------- GetCompanySubscription ------------------------------');
    var list = <Subscription>[];
    if (result.statusCode == 200) {
      for (var item in result.data) {
        list.add(Subscription.fromJson(item));
      }
    }

    return list;
  }

  @override
  Future<Subscription> getSubcripation(int userId, int comanyId) async {
    var result = await _dio.get(
        'https://localhost:7092/api/Subscription/GetCompanySubscription',
        queryParameters: {'userId': userId, 'companyId': comanyId});
    print(
        '-------------------------------- GetCompanySubscription ------------------------------');
    return Subscription.fromJson(result.data);
  }
}
