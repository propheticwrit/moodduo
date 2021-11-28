import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'survey_state.dart';

class SurveyCubit extends Cubit<SurveyState> {
  SurveyCubit() : super(SurveyInitial());
}
