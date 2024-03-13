import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:propertio_mobile/data/model/responses/detail_developer_response_model.dart';
import 'package:propertio_mobile/shared/api_path.dart';

class DeveloperRemoteDataSource {
  Future<Either<String, DetailDeveloperResponseModel>> getDetailDeveloper(
      String id,
      {int? page}) async {
    var url =
        Uri.parse(ApiPath.baseUrl + '/v1/developer/$id?page=${page ?? 1}');
    final response = await http.get(url);

    print(response.body);
    if (response.statusCode == 200) {
      return Right(
          DetailDeveloperResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Server Error');
    }
  }
}