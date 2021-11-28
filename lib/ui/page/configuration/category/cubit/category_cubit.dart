import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/data/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required this.category}) : super(CategoryInitial());

  final Category category;

  Future<String?> _authToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  void editCategory() async {
    String? authToken = await _authToken();
    if (authToken != null) {
      Repository repository = Repository(authToken: authToken);
      repository.editCategory(Category(
          id: category.id,
          name: category.name,
          parent: category.parent,
          created: category.created,
          user: [category.user]));
      emit(CategorySubmitted());
    } else {
      emit(TokenDoesNotExist());
    }
  }

  // Future<void> _submitSurvey(Survey survey) async {
  //   if (_validateAndSaveForm()) {
  //     SurveyBloc surveyBloc = SurveyBloc(category: category);
  //     surveyBloc.editSurvey(survey);
  //     setState(() {
  //       _showSurveyInput = '';
  //       _showSurveyQuestion = -1;
  //       _showSurveyQuestions = '';
  //     });
  //   }
  // }

  // Future<void> _addSurvey(BuildContext context) async {
  //   if (_validateAndSavePopupForm()) {
  //     var uuid = Uuid();
  //     Survey survey = Survey(id: uuid.v4(), name: _addedSurveyName, category: [category.id]);
  //     SurveyBloc surveyBloc = SurveyBloc(category: category);
  //     surveyBloc.addSurvey(survey);
  //     if ( category.surveys != null ) {
  //       category.surveys!.add(survey);
  //     } else {
  //       category.surveys = [survey];
  //     }
  //     setState(() {
  //       Navigator.of(context).pop(true);
  //     });
  //   }
  // }

  // Future<void> _submitQuestion(Survey survey, Question question) async {
  //   if (_validateAndSaveForm()) {
  //     QuestionBloc questionBloc = QuestionBloc(survey: survey);
  //     questionBloc.editQuestion(question);
  //     setState(() {
  //       _showSurveyQuestion = -1;
  //     });
  //   }
  // }
}
