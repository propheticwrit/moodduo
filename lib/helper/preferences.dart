import 'package:mood/data/model/mood_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<User?> getPrefUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');
    String? id = prefs.getString('userID');
    if (id != null && authToken != null) {
      print('Auth Token: $authToken');
      return User(id: int.parse(id), idToken: authToken);
    } else {
      return null;
    }
  }
}
