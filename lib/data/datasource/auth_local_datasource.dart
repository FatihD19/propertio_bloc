import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:propertio_bloc/data/model/request/login_request_model.dart';
import 'package:propertio_bloc/data/model/responses/login_response_model.dart';
import 'package:propertio_bloc/injection.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage storage = locator<FlutterSecureStorage>();
  Future<void> storeCredentialToLocal(UserModel user, String token) async {
    try {
      await storage.write(key: 'token', value: token);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
      await storage.write(key: 'isLogin', value: 'true');
      await storage.write(key: 'idAccount', value: user.accountId);
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginRequestModel> getCredentialFromLocal() async {
    try {
      Map<String, String> values = await storage.readAll();
      if (values['email'] == null && values['password'] == null) {
        throw 'autthenticated';
      } else {
        final LoginRequestModel data = LoginRequestModel(
          email: values['email'],
          password: values['password'],
        );
        print('${data.password} ${data.email}');
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> statusLogin() async {
    bool isLogin = false;
    final FlutterSecureStorage storage = locator<FlutterSecureStorage>();
    String? value = await storage.read(key: 'isLogin');
    if (value != null) {
      isLogin = true;
    }
    return isLogin;
  }

  static getToken() async {
    String token = '';
    final FlutterSecureStorage storage = locator<FlutterSecureStorage>();
    String? value = await storage.read(key: 'token');

    if (value != null) {
      token = 'Bearer $value';
    }
    // print('token: $token');
    return token;
  }

  static Future<String> getIdAccount() async {
    String idAccount = '';
    final FlutterSecureStorage storage = locator<FlutterSecureStorage>();
    String? value = await storage.read(key: 'idAccount');

    if (value != null) {
      idAccount = value;
    }
    return idAccount;
  }

  Future<void> clearLocalStorage() async {
    final FlutterSecureStorage storage = locator<FlutterSecureStorage>();
    await storage.deleteAll();
  }
}
