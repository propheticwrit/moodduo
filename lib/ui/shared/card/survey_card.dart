import 'package:flutter/material.dart';
import 'package:mood/data/model/survey.dart';
import 'package:mood/ui/shared/base_card.dart';
import 'package:mood/ui/shared/icon/circle_avatar.dart';

class SurveyCard extends BaseCard {
  SurveyCard({
    Key? key,
    required Survey survey,
    required List<Widget> questionList,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 5.0),
                leading: const CardAvatar(text: 'SV'),
                title: Text(
                  survey.name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_circle_up_rounded),
                  iconSize: 20.0,
                  color: Colors.grey,
                  onPressed: onPressed,
                ),
              ),
              Column(
                children: questionList,
              ),
            ],
          ),
        );
}
