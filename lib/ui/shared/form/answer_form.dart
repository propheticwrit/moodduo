import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mood/constants/strings.dart';
import 'package:mood/data/model/answer.dart';

class AnswerForm extends StatelessWidget {
  final Answer answer;
  final VoidCallback onTap;

  const AnswerForm({Key? key, required this.answer, required this.onTap})
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
          //statements;
        }
        break;

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
          return FormBuilderTextField(
            name: answer.name ?? '',
            decoration: InputDecoration(
              labelText: answer.label ?? '',
            ),
            onChanged: (value) => {},
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.max(context, 70),
            ]),
            keyboardType: TextInputType.number,
          );
        }
    }
    return Container();
  }
}
