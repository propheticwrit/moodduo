import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/data/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'configuration_state.dart';

class ConfigurationCubit extends Cubit<ConfigurationState> {
  ConfigurationCubit() : super(ConfigurationInitial());

  Future<String?> _authToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  void fetchCategories() async {
    String? authToken = await _authToken();
    print('IDToken in Configuration Cubit: $authToken');
    if (authToken != null) {
      Repository repository = Repository(authToken: authToken);
      repository.fetchCategories().then((value) {
        emit(ConfigurationLoaded(baseCategories: value));
      });
    } else {
      emit(ConfigurationError());
    }
  }
}
