import 'package:http/http.dart' as http;
import 'package:propertio_mobile/data/model/request/send_message_request_model.dart';
import 'dart:convert';

import 'package:propertio_mobile/shared/api_path.dart';

class SendMessageRemoteDataSource {
  Future<bool> sendMessage(
      {SendMessagePropertyRequestModel? property,
      SendMessageProjectRequestModel? project}) async {
    var url = project == null
        ? Uri.parse(ApiPath.baseUrl + '/v1/property/message')
        : Uri.parse(ApiPath.baseUrl + '/v1/project/message');
    final response = await http.post(url,
        body: project == null ? property?.toJson() : project.toJson()
        // body:property?.toJson()
        // json.encode(project == null ? property?.toJson() : project.toJson()),
        );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 422) {
      return false;
    } else {
      return false;
    }
  }
}