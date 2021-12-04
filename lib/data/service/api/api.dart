import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

class API {
  Future<http.Response> _validateResponse(http.Response response) async {
    if (response.statusCode ~/ 100 == 2) {
      return response;
    } else if (response.statusCode ~/ 100 == 4) {
      throw const HttpException('Permissions Error');
    } else if (response.statusCode ~/ 100 == 5) {
      throw const HttpException('Internal Server Error');
    } else {
      throw const HttpException('Server Error');
    }
  }

  // body can be a string, list of strings or map
  Future<http.Response> post(
      {required Uri uri,
      Map<String, String>? headers,
      required Object body}) async {
    try {
      http.Response response = await http
          .post(uri, headers: headers, body: body)
          .timeout(const Duration(seconds: 5));
      return _validateResponse(response);
    } on TimeoutException catch (e) {
      throw HttpException(e.message ?? 'Request Timed Out');
    }
  }

  Future<http.Response> patch(
      {required Uri uri,
      Map<String, String>? headers,
      required Object body}) async {
    try {
      http.Response response = await http
          .patch(uri, headers: headers, body: body)
          .timeout(const Duration(seconds: 5));
      return _validateResponse(response);
    } on TimeoutException catch (e) {
      throw HttpException(e.message ?? 'Request Timed Out');
    }
  }

  Future<http.Response> get(
      {required Uri uri, Map<String, String>? headers}) async {
    try {
      http.Response response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 5));
      return _validateResponse(response);
    } on TimeoutException catch (e) {
      throw HttpException(e.message ?? 'Request Timed Out');
    }
  }

  Future<http.Response> delete(
      {required Uri uri, Map<String, String>? headers}) async {
    try {
      http.Response response = await http
          .delete(uri, headers: headers)
          .timeout(const Duration(seconds: 5));
      return _validateResponse(response);
    } on TimeoutException catch (e) {
      throw HttpException(e.message ?? 'Request Timed Out');
    }
  }
}
