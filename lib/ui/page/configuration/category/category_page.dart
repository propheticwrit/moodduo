import 'package:flutter/material.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/data/model/question.dart';
import 'package:mood/data/model/survey.dart';
import 'package:mood/ui/shared/form/text.dart';
import 'package:mood/ui/shared/list/add_item.dart';
import 'package:mood/ui/shared/list/configuration_item.dart';
import 'package:uuid/uuid.dart';

class EditCategoryPage extends StatefulWidget {
  const EditCategoryPage({required this.category, Key? key}) : super(key: key);

  final Category category;

  static Future<void> show(
      {required BuildContext context, required Category category}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditCategoryPage(category: category),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final _popupFormKey = GlobalKey<FormState>();

  Category? category;
  final List<String> _questionTypes = ['Text', 'Toggle', 'Date', 'Switch'];

  bool _showCategoryInput = false;
  String _showSurveyInput = '';
  String _showSurveyQuestions = '';

  int _showSurveyQuestion = -1;

  String _addedSurveyName = '';
  String _addedQuestionName = '';
  String _addedQuestionType = '';

  @override
  void initState() {
    super.initState();
  }

  List<String> _categorySurveyNames() {
    List<String> surveyNames = [];
    if (category!.surveys != null && category!.surveys!.isNotEmpty) {
      for (Survey survey in category!.surveys!) {
        surveyNames.add(survey.name);
      }
    }
    return surveyNames;
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();
        return true;
      }
    }
    return false;
  }

  bool _validateAndSavePopupForm() {
    final form = _popupFormKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();
        return true;
      }
    }
    return false;
  }

  Future<void> _submitCategory() async {
    if (_validateAndSaveForm()) {
      // CategoryListBloc categoryListBloc = CategoryListBloc();
      // categoryListBloc.editCategory(Category(
      //     id: category.id,
      //     name: category.name,
      //     parent: category.parent,
      //     created: category.created));
      setState(() {
        _showCategoryInput = false;
      });
    }
  }

  Future<void> _submitSurvey(Survey survey) async {
    if (_validateAndSaveForm()) {
      // SurveyBloc surveyBloc = SurveyBloc(category: category);
      // surveyBloc.editSurvey(survey);
      setState(() {
        _showSurveyInput = '';
        _showSurveyQuestion = -1;
        _showSurveyQuestions = '';
      });
    }
  }

  Future<void> _addSurvey(BuildContext context) async {
    if (_validateAndSavePopupForm()) {
      var uuid = Uuid();
      // Survey survey = Survey(
      //     id: uuid.v4(), name: _addedSurveyName, category: [category.id]);
      // SurveyBloc surveyBloc = SurveyBloc(category: category);
      // surveyBloc.addSurvey(survey);
      // if (category.surveys != null) {
      //   category.surveys!.add(survey);
      // } else {
      //   category.surveys = [survey];
      // }
      setState(() {
        Navigator.of(context).pop(true);
      });
    }
  }

  Future<void> _submitQuestion(Survey survey, Question question) async {
    if (_validateAndSaveForm()) {
      // QuestionBloc questionBloc = QuestionBloc(survey: survey);
      // questionBloc.editQuestion(question);
      setState(() {
        _showSurveyQuestion = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    category = widget.category;
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Edit Category ${category!.name}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              _showCategoryInput
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Expanded(
                            flex: 2,
                            child: FormTextField(
                              labelText: 'Category Name',
                              initialValue: category!.name,
                              existingNames: const [],
                              onSavedName: (value) => category!.name = value,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.save),
                            iconSize: 25.0,
                            color: Colors.grey,
                            onPressed: _submitCategory,
                          )
                        ])
                  : ConfigurationItem(
                      name: category!.name,
                      onTap: () {},
                      leading: const CircleAvatar(
                        radius: 15,
                        child: Text(
                          'CT',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                        backgroundColor: Colors.orange,
                      ),
                      trailingPressed: () =>
                          setState(() => _showCategoryInput = true),
                    ),
              const SizedBox(height: 40.0),
              _surveyList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _surveyList() {
    List<Widget> surveyRows = <Widget>[];

    if (category!.surveys != null) {
      for (Survey survey in category!.surveys!) {
        surveyRows.add(
          _showSurveyInput == survey.id
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Expanded(
                        flex: 2,
                        child: FormTextField(
                          labelText: 'Survey Name',
                          initialValue: survey.name,
                          existingNames: _categorySurveyNames(),
                          onSavedName: (value) => survey.name = value,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.save),
                        iconSize: 25.0,
                        color: Colors.grey,
                        onPressed: () => _submitSurvey(survey),
                      ),
                    ])
              : ConfigurationItem(
                  name: survey.name,
                  onTap: () => setState(() => _showSurveyQuestions = survey.id),
                  leading: const CircleAvatar(
                    radius: 15,
                    child: Text(
                      'SV',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  trailingPressed: () =>
                      setState(() => _showSurveyInput = survey.id),
                ),
        );
        surveyRows.add(const SizedBox(height: 10));
        if (_showSurveyQuestions == survey.id) {
          surveyRows.add(_questionList(survey));
        }
      }
    }
    surveyRows.add(AddItem(
      label: 'Add Survey',
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Add Survey'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _popupFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Survey Name'),
                    initialValue: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name can\'t be empty';
                      }
                      if (_categorySurveyNames().contains(value)) {
                        return 'Name already exists';
                      }
                      return null;
                    },
                    onSaved: (value) => _addedSurveyName = value ?? '',
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              child: const Text('Submit'),
              onPressed: () => _addSurvey(context),
            ),
          ],
        ),
      ),
    ));
    return ListView(
        scrollDirection: Axis.vertical, shrinkWrap: true, children: surveyRows);
  }

  Widget _questionList(Survey survey) {
    List<Widget> questionRows = <Widget>[];

    if (survey.questions != null) {
      for (var index = 0; index < survey.questions!.length; index++) {
        Question question = survey.questions![index];
        questionRows.add(
          _showSurveyInput == index
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Expanded(
                        flex: 2,
                        child: FormTextField(
                          labelText: 'Question Name',
                          initialValue:
                              question.name != null ? question.name! : '',
                          existingNames: [],
                          onSavedName: (value) => question.name = value,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.save),
                        iconSize: 25.0,
                        color: Colors.grey,
                        onPressed: () => _submitQuestion(survey, question),
                      ),
                    ])
              : ConfigurationItem(
                  name: question.name != null ? question.name! : '',
                  onTap: () {},
                  leading: const CircleAvatar(
                    radius: 15,
                    child: Text(
                      'QT',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  trailingPressed: () =>
                      setState(() => _showSurveyQuestion = index),
                ),
        );
      }
    }
    questionRows.add(AddItem(label: 'Add Question', onPressed: () => {}));
    return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: questionRows);
  }
}
