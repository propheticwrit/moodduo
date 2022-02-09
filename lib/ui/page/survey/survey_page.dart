import 'package:flutter/material.dart';
import 'package:mood/data/model/answer.dart';
import 'package:mood/data/model/question.dart';
import 'package:mood/data/model/survey.dart';
import 'package:mood/ui/page/survey/cubit/survey_cubit.dart';
import 'package:mood/ui/shared/form/survey_form.dart';

class SurveyPage extends StatefulWidget {
  SurveyPage({Key? key, this.survey}) : super(key: key);

  final Survey? survey;

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  Map<String, List<Answer>> questionAnswers = <String, List<Answer>>{};

  int _counter = 0;

  incrementCounter(newNumber) {
    if (newNumber != _counter) {
      setState(() {
        _counter = newNumber;
        print('$_counter');
      });
    }
  }

  addSurvey() async {
    // SurveyCubit s = SurveyCubit();
    // if (widget.survey != null && widget.survey!.questions != null) {
    //   for (Question question in widget.survey!.questions!) {
    //     if (question.answers != null) {
    //       for (Answer answer in question.answers!) {
    //         // print(
    //         //     '${question.name! + '.' + answer.name!} ${_fbKey.currentState!.value[question.name! + '.' + answer.name!]}');
    //       }
    //     }
    //   }
    // }
  }

  _onAdd(Question question, List<Answer>? answers) {
    if (answers != null) {
      for (String questionID in questionAnswers.keys) {
        if (question.id == questionID && questionAnswers[questionID] != null) {
          questionAnswers[questionID]!.addAll(answers);
        } else {
          questionAnswers[questionID] = answers;
        }
      }
      // setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.survey != null
            ? SurveyForm(
                onTap: incrementCounter,
                onAdd: _onAdd,
                onSubmit: addSurvey,
                questionAnswers: questionAnswers,
                survey: widget.survey!)
            : const Center(child: Text('Survey')));
  }
}
