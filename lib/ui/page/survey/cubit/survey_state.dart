part of 'survey_cubit.dart';

abstract class SurveyState extends Equatable {
  const SurveyState();

  @override
  List<Object> get props => [];
}

class SurveyInitial extends SurveyState {}

class SurveySaved extends SurveyState {}

class SurveyError extends SurveyState {
  final String message;

  const SurveyError({required this.message});
}
