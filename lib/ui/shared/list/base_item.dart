import 'package:flutter/material.dart';
import 'package:mood/ui/shared/base_card.dart';

class BaseItem extends BaseCard {
  BaseItem(
      {Key? key,
      required String name,
      required Widget leading,
      required VoidCallback onTap,
      required VoidCallback onPressed,
      required VoidCallback onLongPress})
      : super(
          key: key,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 5.0),
            leading: leading,
            title: Text(
              name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.keyboard_arrow_right),
              iconSize: 20.0,
              color: Colors.grey,
              onPressed: onPressed,
            ),
            onTap: onTap,
            onLongPress: onLongPress,
          ),
        );
}
