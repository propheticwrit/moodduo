import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/data/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<String?> _authToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  void fetchCategories() async {
    String? authToken = await _authToken();
    print('IDToken in Home Cubit: $authToken');
    if (authToken != null) {
      Repository repository = Repository(authToken: authToken);
      repository.fetchCategories().then((value) {
        emit(HomeLoaded(baseCategories: value));
      });
    } else {
      emit(HomeError());
    }
  }
}
