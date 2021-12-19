import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mood/constants/strings.dart';
import 'package:mood/data/model/answer.dart';
import 'package:mood/data/model/question.dart';
import 'package:mood/data/model/survey.dart';
import 'package:mood/ui/shared/base_card.dart';
import 'package:mood/ui/shared/card/survey_card.dart';
import 'package:mood/ui/shared/form/answer_form.dart';
import 'package:mood/ui/shared/icon/circle_avatar.dart';

class SurveyForm extends StatelessWidget {
  final Survey survey;
  final GlobalKey<FormBuilderState> formKey;
  final VoidCallback onTap;

  const SurveyForm(
      {Key? key,
      required this.survey,
      required this.onTap,
      required this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List l = _survey(context);
    return FormBuilder(
      key: formKey,
      child: ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          return l[index];
        },
      ),
    );
  }

  List<Widget> _survey(BuildContext context) {
    List<Widget> surveyList = [];
    surveyList.add(
      ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 5.0),
        leading: const CardAvatar(text: 'SV'),
        title: Text(
          survey.name,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_circle_up_rounded),
          iconSize: 20.0,
          color: Colors.grey,
          onPressed: () => {},
        ),
      ),
    );
    surveyList.addAll(_questionList(context));

    surveyList.add(_submitButtons());
    return surveyList;
  }

  Widget _submitButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          child: const Text(
            "Submit",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green,
          onPressed: () {
            formKey.currentState!.save();
            if (formKey.currentState!.validate()) {
              print(formKey.currentState!.value);
            }
          },
        ),
        MaterialButton(
          child: const Text(
            "Reset",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.deepOrange,
          onPressed: () {
            formKey.currentState!.reset();
          },
        ),
      ],
    );
  }

  List<Widget> _questionList(BuildContext context) {
    List<Widget> questionsList = [];
    if (survey.questions != null) {
      for (Question question in survey.questions!) {
        questionsList.add(
          const Divider(
            color: Colors.grey,
          ),
        );
        questionsList.add(
          BaseCard(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ListTile(
                title: Text(
                  question.name != null ? question.name! : '',
                  style: const TextStyle(color: Colors.black54, fontSize: 16),
                ),
                subtitle: Column(children: _answerList(question)),
              ),
            ),
          ),
        );
      }
    }
    return questionsList;
  }

  List<Widget> _answerList(Question question) {
    List<Widget> answerList = [];
    if (question.answers != null) {
      for (Answer answer in question.answers!) {
        answerList.add(Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: ListTile(
            title: AnswerForm(
              answer: answer,
              onTap: () {},
            ),
          ),
        ));
      }
    }

    return answerList;
  }
}
