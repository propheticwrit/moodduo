import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mood/data/model/answer.dart';
import 'package:mood/data/model/question.dart';
import 'package:mood/data/model/survey.dart';
import 'package:mood/ui/shared/card/survey_card.dart';
import 'package:mood/ui/shared/form/answer_form.dart';
import 'package:mood/ui/shared/form/survey_form.dart';

class SurveyPage extends StatelessWidget {
  SurveyPage({Key? key, this.survey}) : super(key: key);

  final Survey? survey;

  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: survey != null
            ? SurveyForm(onTap: () {}, survey: survey!, formKey: _fbKey)
            : const Center(child: Text('Survey')));
  }
}
