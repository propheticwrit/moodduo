import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/data/model/mood_user.dart';
import 'package:mood/data/repository/repository.dart';
import 'package:mood/helper/preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<Repository> getRepository() async {
    User? user = await Preferences.getPrefUser();
    if (user == null) {
      emit(const HomeError(message: 'Authorization token does not exist'));
    }
    return Repository(authToken: user!.idToken!);
  }

  void fetchCategories() async {
    try {
      Repository repository = await getRepository();
      repository.fetchCategories().then((value) {
        emit(HomeLoaded(baseCategories: value));
      }).onError<HttpException>((error, stackTrace) {
        emit(HomeError(message: error.message));
      });
    } on HttpException catch (e) {
      emit(HomeError(message: e.message));
    }
  }
}
