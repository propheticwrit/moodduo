import 'package:mood/data/model/category.dart';
import 'package:mood/data/service/api/connector.dart';
import 'package:mood/data/service/api/mood_api.dart';

class Repository {
  String authToken;

  late Connector connector;

  Repository({required this.authToken}) {
    connector = MoodAPI(authToken: authToken);
  }

  Future<Map<Category, List<Category>>> fetchCategories() async {
    return await connector.completeCategories();
  }

  Future<Category> editCategory(Category category) async {
    return await connector.editCategory(category);
  }
}
