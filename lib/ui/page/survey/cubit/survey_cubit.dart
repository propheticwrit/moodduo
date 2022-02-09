import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mood/data/model/mood_user.dart';
import 'package:mood/data/model/survey.dart';
import 'package:mood/data/repository/repository.dart';
import 'package:mood/helper/preferences.dart';

part 'survey_state.dart';

class SurveyCubit extends Cubit<SurveyState> {
  SurveyCubit() : super(SurveyInitial());

  Future<Repository> getRepository() async {
    User? user = await Preferences.getPrefUser();
    if (user == null) {
      emit(const SurveyError(message: 'Authorization token does not exist'));
    }
    return Repository(authToken: user!.idToken!);
  }

  void addSurvey(Survey survey) async {
    try {
      Repository repository = await getRepository();
      repository.addSurvey(survey).then((value) {
        emit(SurveySaved());
      }).onError<HttpException>((error, stackTrace) {
        emit(SurveyError(message: error.message));
      });
    } on HttpException catch (e) {
      emit(SurveyError(message: e.message));
    }
  }
}
