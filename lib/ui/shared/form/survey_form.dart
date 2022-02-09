import 'package:flutter/material.dart';
import 'package:mood/data/model/answer.dart';
import 'package:mood/data/model/question.dart';
import 'package:mood/data/model/survey.dart';
import 'package:mood/ui/shared/base_card.dart';
import 'package:mood/ui/shared/form/answer_form.dart';
import 'package:mood/ui/shared/icon/circle_avatar.dart';

class SurveyForm extends StatelessWidget {
  final Survey survey;
  final Map<String, List<Answer>> questionAnswers;

  final Function(int d) onTap;
  final Function(Question question, List<Answer>? answers) onAdd;
  final VoidCallback onSubmit;

  const SurveyForm(
      {Key? key,
      required this.survey,
      required this.questionAnswers,
      required this.onTap,
      required this.onAdd,
      required this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List l = _survey(context);
    return ListView.builder(
      itemCount: l.length,
      itemBuilder: (context, index) {
        return l[index];
      },
    );
  }

  List<Widget> _survey(BuildContext context) {
    List<Widget> surveyList = [];
    surveyList.add(
      ListTile(
        dense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 5.0),
        leading: const CardAvatar(text: 'SV'),
        title: Text(
          survey.name,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),
    );
    surveyList.addAll(_questionList(context));
    surveyList.add(
      const Divider(
        color: Colors.grey,
      ),
    );
    surveyList.add(_submitButtons());
    return surveyList;
  }

  Widget _submitButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          child: const Text(
            "Submit",
            style: TextStyle(color: Colors.black54, fontSize: 15),
          ),
          onPressed: () {
            // if (formKey.currentState!.validate()) {
            onSubmit();
            // }
          },
        ),
        OutlinedButton(
          child: const Text(
            "Reset",
            style: TextStyle(color: Colors.black54, fontSize: 15),
          ),
          onPressed: () {
            // formKey.currentState!.reset();
          },
        ),
      ],
    );
  }

  List<Widget> _questionList(BuildContext context) {
    List<Widget> questionsList = [];
    if (survey.questions != null) {
      for (Question question in survey.questions!) {
        if (questionAnswers.containsKey(question.id)) {
          questionsList.add(
            Row(
              children: [
                Expanded(
                  child: Text(
                    questionAnswers[question.id].toString(),
                  ),
                ),
              ],
            ),
          );
        }
        questionsList.add(
          const Divider(
            color: Colors.grey,
          ),
        );
        questionsList.add(
          BaseCard(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListTile(
                    title: Text(
                      question.name != null ? question.name! : '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 15),
                    ),
                    subtitle: Row(children: _answerList(question)),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    return questionsList;
  }

  // List<Widget> _answerRows(String id) {
  //   List<Widget> answerList = [];
  //   if (questionAnswers.containsKey(question.id)) {
  //     for (Answer answer in questionAnswers[id]!) {
  //       answerList.add(Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.all(14.0),
  //           child: Text(),
  //         ),
  //       ));
  //     }
  //   }
  // }

  List<Widget> _answerList(Question question) {
    List<Widget> answerList = [];
    if (question.answers != null) {
      for (Answer answer in question.answers!) {
        answerList.add(Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: AnswerForm(
              question: question,
              answer: answer,
              onTap: () {},
              onSaved: (Question question, Answer answer, dynamic value) {
                print('${question.name} ${answer.name} $value');
              },
            ),
          ),
        ));
      }
    }

    answerList.add(
      IconButton(
        icon: const Icon(Icons.add),
        iconSize: 20.0,
        color: Colors.grey,
        onPressed: onAdd(question, question.answers),
        // onPressed: () => onTap,
      ),
    );

    return answerList;
  }
}
