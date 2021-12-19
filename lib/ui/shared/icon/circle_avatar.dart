import 'package:flutter/material.dart';

class CardAvatar extends StatelessWidget {
  final String text;

  const CardAvatar({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black45,
      radius: 17.0,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 16.0,
        child: Text(
          text,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }
}
