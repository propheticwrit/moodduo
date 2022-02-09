import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mood/data/model/mood_user.dart';
import 'package:mood/data/service/api/api.dart';
import 'package:mood/data/service/api/api_path.dart';

class MoodAuthenticator extends API {
  var client = Client();

  Future<User> login(String authToken) async {
    Response response = await post(Uri.http(APIPath.url, APIPath.login()),
        headers: {'Content-Type': 'application/json'},
        body: "{\"auth_token\": \"$authToken\"}");
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse.isNotEmpty && jsonResponse.containsKey('username')) {
      int id = jsonResponse['id'];
      String username = jsonResponse['username'];
      String email = jsonResponse['email'];
      if (jsonResponse.containsKey('tokens')) {
        // String refreshToken = jsonResponse['tokens']['refresh'];
        String accessToken = jsonResponse['tokens']['access'];

        return User(id: id, name: username, email: email, idToken: accessToken);
      } else {
        throw const HttpException('Invalid response format. No tokens found.');
      }
    } else {
      throw const HttpException('Invalid response format');
    }
  }
}
