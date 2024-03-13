import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:propertio_mobile/data/datasource/auth_local_datasource.dart';
import 'package:propertio_mobile/data/model/responses/detail_project_progress_response_model.dart';
import 'dart:convert';

import 'package:propertio_mobile/data/model/responses/list_projectProgress_response_model.dart';
import 'package:propertio_mobile/data/model/responses/project_progress_page_response_model.dart';
import 'package:propertio_mobile/shared/api_path.dart';

class MonitoringRemoteDataSource {
  Future<Either<String, ListProjectProgressResponseModel>>
      getProjectProgress() async {
    var url = Uri.parse(ApiPath.baseUrl + '/v1/project-progress-lists');
    final token = await AuthLocalDataSource.getToken();

    final response = await http.get(url, headers: {
      'Authorization': token,
    });
    print(response.body);
    if (response.statusCode == 200) {
      return Right(
          ListProjectProgressResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, ProgressProjectPageResponseModel>>
      getProjectProgressPage(String id) async {
    var url =
        Uri.parse(ApiPath.baseUrl + '/v1/project-progress-lists/progress/$id');
    final token = await AuthLocalDataSource.getToken();
    final response = await http.get(url, headers: {'Authorization': token});

    print(response.body);
    if (response.statusCode == 200) {
      return Right(
          ProgressProjectPageResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, DetailProjectProgressResponseModel>>
      getDetailProjectProgress(String id) async {
    var url = Uri.parse(
        ApiPath.baseUrl + '/v1/project-progress-lists/progress-detail/$id');
    final token = await AuthLocalDataSource.getToken();
    final response = await http.get(url, headers: {'Authorization': token});

    print(response.body);
    if (response.statusCode == 200) {
      return Right(DetailProjectProgressResponseModel.fromJson(
          jsonDecode(response.body)));
    } else {
      return const Left('Server Error');
    }
  }
}
