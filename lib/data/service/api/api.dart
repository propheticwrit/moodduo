import 'dart:async';

import 'package:http/http.dart';

class API {
  // body can be a string, list of strings or map
  Future<Response> post(
      {required Uri uri,
      Map<String, String>? headers,
      required Object body}) async {
    return await post(uri: uri, headers: headers, body: body);
  }

  Future<Response> patch(
      {required Uri uri,
      Map<String, String>? headers,
      required Object body}) async {
    return await patch(uri: uri, headers: headers, body: body);
  }

  Future<Response> get({required Uri uri, Map<String, String>? headers}) async {
    return await get(uri: uri, headers: headers);
  }

  Future<Response> delete(
      {required Uri uri, Map<String, String>? headers}) async {
    return await delete(uri: uri, headers: headers);
  }
}
