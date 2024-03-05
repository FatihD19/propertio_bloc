import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:propertio_mobile/data/datasource/auth_local_datasource.dart';

import 'package:propertio_mobile/data/model/request/login_request_model.dart';
import 'package:propertio_mobile/data/model/responses/login_response_model.dart';
import 'package:propertio_mobile/shared/api_path.dart';

class AuthRemoteDataSource {
  Future<Either<String, LoginResponseModel>> login(
      LoginRequestModel data) async {
    var url = Uri.parse(ApiPath.baseUrl + '/v1/auth/login');
    final response = await http.post(url, body: data.toJson());
    if (response.statusCode == 200) {
      print(response.body);
      LoginResponseModel loginResponseModel =
          LoginResponseModel.fromJson(json.decode(response.body));
      await AuthLocalDataSource().storeCredentialToLocal(
          loginResponseModel.data!.user!
              .copyWith(email: data.email, password: data.password),
          loginResponseModel.data!.token!);
      return Right(loginResponseModel);
    } else {
      return Left('Server Error');
    }
  }
}
