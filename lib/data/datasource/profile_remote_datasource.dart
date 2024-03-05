import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:propertio_mobile/data/datasource/auth_local_datasource.dart';
import 'package:propertio_mobile/data/model/responses/profil_response_model.dart';
import 'package:propertio_mobile/shared/api_path.dart';

class ProfileRemoteDataSource {
  Future<Either<String, ProfilResponseModel>> getProfile() async {
    var url = Uri.parse(ApiPath.baseUrl + '/v1/profile');
    final token = await AuthLocalDataSource.getToken();
    final response = await http.get(url, headers: {
      'Authorization': token,
    });

    print(response.body);
    if (response.statusCode == 200) {
      return Right(ProfilResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left('Server Error');
    }
  }
}
