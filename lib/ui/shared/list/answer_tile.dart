import 'package:flutter/material.dart';
import 'package:mood/data/model/answer.dart';

class AnswerTile extends StatelessWidget {
  final Answer answer;
  final VoidCallback onTap;

  const AnswerTile({Key? key, required this.answer, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.grey)),
        title: Text(
          answer.name != null ? answer.name! : '',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          answer.label != null ? answer.label! : '',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        trailing: const Icon(
          // Constants.ANSWER_ICONS[answer.style],
          Icons.edit,
          size: 24.0,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
