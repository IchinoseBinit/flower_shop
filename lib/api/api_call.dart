import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import '/api/api_client.dart';
import '/constants/urls.dart';
import '/utils/request_type.dart';

class APICall {
  final APIClient _client = APIClient(Client());

  postRequestWithoutToken(Map body) async {
    try {
      Response _response = await _callApi(body, RequestType.post);
      log(_response.body);
      if (_response.statusCode == 200) {
        return _response.body;
      }
      throw jsonDecode(_response.body)["error"];
    } catch (ex) {
      rethrow;
    }
  }

  _callApi(Map body, RequestType requestType) async {
    return await _client.request(
      requestType: requestType,
      url: registerUrl,
      parameter: jsonEncode(body),
    );
  }
}
