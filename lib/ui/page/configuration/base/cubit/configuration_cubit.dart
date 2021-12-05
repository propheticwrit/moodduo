import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/data/model/mood_user.dart';
import 'package:mood/data/repository/repository.dart';
import 'package:mood/helper/preferences.dart';

part 'configuration_state.dart';

class ConfigurationCubit extends Cubit<ConfigurationState> {
  ConfigurationCubit() : super(ConfigurationInitial());

  int? userID;

  Future<Repository> getRepository() async {
    User? user = await Preferences.getPrefUser();
    if (user == null) {
      emit(const ConfigurationError(
          message: 'Authorization token does not exist'));
    }
    userID = user!.id;
    return Repository(authToken: user.idToken!);
  }

  void fetchCategories() async {
    try {
      Repository repository = await getRepository();
      repository.fetchCategories().then((value) {
        emit(ConfigurationLoaded(baseCategories: value));
      }).onError<HttpException>((error, stackTrace) {
        emit(ConfigurationError(message: error.message));
      });
    } on HttpException catch (e) {
      emit(ConfigurationError(message: e.message));
    }
  }

  void addCategory(Category category) async {
    try {
      Repository repository = await getRepository();
      category.user = [userID!];
      repository.addCategory(category).then((value) {
        emit(CategoryAdded(category: value));
      }).onError<HttpException>((error, stackTrace) {
        emit(CategoryAddError(message: error.message));
      });
    } on HttpException catch (e) {
      emit(CategoryAddError(message: e.message));
    }
  }

  void deleteCategory(Category category) async {
    try {
      Repository repository = await getRepository();
      repository.deleteCategory(category).then((value) {
        emit(CategoryDeleted(deleted: value));
      }).onError<HttpException>((error, stackTrace) {
        emit(CategoryDeleteError(message: error.message));
      });
    } on HttpException catch (e) {
      emit(CategoryDeleteError(message: e.message));
    }
  }
}
