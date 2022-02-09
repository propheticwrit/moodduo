import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mood/constants/strings.dart';
import 'package:mood/data/model/answer.dart';
import 'package:mood/data/model/question.dart';

class AnswerForm extends StatelessWidget {
  final Question question;
  final Answer answer;
  final VoidCallback onTap;
  final Function(Question, Answer, dynamic) onSaved;

  final _fbKey = GlobalKey<FormBuilderState>();

  AnswerForm(
      {Key? key,
      required this.question,
      required this.answer,
      required this.onTap,
      required this.onSaved})
      : super(key: key);

  String? _answerInput() {
    if (answer.inputType != null) {
      if (answer.inputType!.type != null) {
        return answer.inputType!.type!;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    switch (_answerInput()) {
      case checkbox:
        {
          // statements;
        }
        break;

      case chips:
        {
          //statements;
        }
        break;

      case dateTime:
        {
          //statements;
        }
        break;

      case dropdown:
        {
          return FormBuilder(
            key: _fbKey,
            child: FormBuilderDropdown(
              name: 'gender',
              decoration: InputDecoration(
                labelText: 'Gender',
              ),
              allowClear: true,
              hint: Text('Select Gender'),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(context)]),
              items: ['abc', 'def', 'ghi']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text('$gender'),
                      ))
                  .toList(),
              onChanged: (value) => {},
              onSaved: (value) => {},
            ),
            // child: FormBuilderTextField(
            //   name: '${question.name}.${answer.name}',
            //   decoration: InputDecoration(
            //     labelStyle:
            //         const TextStyle(color: Colors.black54, fontSize: 13),
            //     contentPadding:
            //         const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            //     border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15.0),
            //         borderSide:
            //             const BorderSide(color: Colors.black54, width: 1.0)),
            //     labelText: answer.label ?? '',
            //   ),
            //   onChanged: (value) => {},
            //   onSaved: (value) => onSaved(question, answer, value),
            //   validator: FormBuilderValidators.compose([
            //     FormBuilderValidators.required(context),
            //     // FormBuilderValidators.max(context, 70),
            //   ]),
            //   keyboardType: TextInputType.number,
            // ),
          );
        }

      case radio:
        {
          //statements;
        }
        break;

      case range:
        {
          //statements;
        }
        break;

      case rate:
        {
          //statements;
        }
        break;

      case segmented:
        {
          //statements;
        }
        break;

      case signature:
        {
          //statements;
        }
        break;

      case slider:
        {
          //statements;
        }
        break;

      case stepper:
        {
          //statements;
        }
        break;

      case switcher:
        {
          //statements;
        }
        break;

      default:
        {
          return FormBuilder(
            key: _fbKey,
            child: FormBuilderTextField(
              name: '${question.name}.${answer.name}',
              decoration: InputDecoration(
                labelStyle:
                    const TextStyle(color: Colors.black54, fontSize: 13),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 1.0)),
                labelText: answer.label ?? '',
              ),
              onChanged: (value) => {},
              onSaved: (value) => onSaved(question, answer, value),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                // FormBuilderValidators.max(context, 70),
              ]),
              keyboardType: TextInputType.number,
            ),
          );
        }
    }
    return Container();
  }
}
