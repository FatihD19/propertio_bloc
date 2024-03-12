import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:propertio_mobile/data/datasource/auth_local_datasource.dart';
import 'package:propertio_mobile/data/model/responses/detail_project_response_model.dart';
import 'package:propertio_mobile/data/model/responses/detail_unit_response_model.dart';
import 'package:propertio_mobile/data/model/responses/list_project_response_model.dart';
import 'dart:convert';

import 'package:propertio_mobile/shared/api_path.dart';

class ProjectRemoteDataSource {
  Future<Either<String, ListProjectModel>> getProject(
      {String? query, int? page, String? type}) async {
    var url = Uri.parse(ApiPath.baseUrl +
        '/v1/project?type=&page=&property_type=${type ?? ''}&page=${page ?? 1}&search=${query ?? ''}');
    final token = await AuthLocalDataSource.getToken();

    final response = await http.get(url, headers: {
      'Authorization': token,
    });
    print(response.body);
    if (response.statusCode == 200) {
      return Right(ListProjectModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, DetailProjectResponseModel>> getDetailProject(
      String slug) async {
    var url = Uri.parse(ApiPath.baseUrl + '/v1/project/$slug');
    final token = await AuthLocalDataSource.getToken();
    final response = await http.get(url, headers: {'Authorization': token});

    print(response.body);
    if (response.statusCode == 200) {
      return Right(
          DetailProjectResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, DetailunitResponseModel>> getDetailUnit(
      String idUnit) async {
    var url = Uri.parse(ApiPath.baseUrl + '/v1/unit/$idUnit');
    final response = await http.get(url);

    print(response.body);
    if (response.statusCode == 200) {
      return Right(DetailunitResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Server Error');
    }
  }
}
