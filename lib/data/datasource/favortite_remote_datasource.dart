import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:propertio_mobile/data/datasource/auth_local_datasource.dart';
import 'package:propertio_mobile/data/model/responses/project_favorite_response_model.dart';
import 'dart:convert';

import 'package:propertio_mobile/data/model/responses/property_favorite_response_model.dart';
import 'package:propertio_mobile/shared/api_path.dart';

class FavoriteRemoteDataSource {
  Future<Either<String, PropertyFavoriteResponseModel>> getFavoriteProperty(
      {int? page}) async {
    var url = Uri.parse(
        ApiPath.baseUrl + '/v1/favorite?page=${page ?? 1}&type=property');
    final token = await AuthLocalDataSource.getToken();
    final response = await http.get(url, headers: {
      'Authorization': token,
    });

    print(response.body);

    if (response.statusCode == 200) {
      return Right(
          PropertyFavoriteResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, ProjectFavoriteResponseModel>> getFavoriteProject(
      {int? page}) async {
    var url = Uri.parse(
        ApiPath.baseUrl + '/v1/favorite?page=${page ?? 1}&type=project');
    final token = await AuthLocalDataSource.getToken();
    final response = await http.get(url, headers: {
      'Authorization': token,
    });

    print(response.body);

    if (response.statusCode == 200) {
      return Right(
          ProjectFavoriteResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Server Error');
    }
  }

  Future<bool> postFavorite({String? propertyCode, String? projectCode}) async {
    var url = projectCode == null
        ? Uri.parse(ApiPath.baseUrl + '/v1/favorite/property')
        : Uri.parse(ApiPath.baseUrl + '/v1/favorite/project');
    final token = await AuthLocalDataSource.getToken();
    final response = await http.post(url,
        headers: {
          'Authorization': token,
        },
        body: propertyCode == null
            ? {'project_code': projectCode}
            : {'property_code': propertyCode});
    if (response.statusCode == 200) {
      print('favorite response: ${response.body}');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFavorite(
      {String? propertyCode, String? projectCode}) async {
    var url = propertyCode == null
        ? Uri.parse(ApiPath.baseUrl + '/v1/favorite/project/$projectCode')
        : Uri.parse(ApiPath.baseUrl + '/v1/favorite/property/$propertyCode');
    final token = await AuthLocalDataSource.getToken();
    final response = await http.delete(url, headers: {
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      print('favorite response: ${response.body}');
      return true;
    } else {
      return false;
    }
  }
}