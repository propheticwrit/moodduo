part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategorySubmitted extends CategoryState {}

class SurveySubmitted extends CategoryState {}

class QuestionSubmitted extends CategoryState {}

class SurveyAdded extends CategoryState {}

class TokenDoesNotExist extends CategoryState {}
