import 'package:flutter/material.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/ui/shared/list/base_item.dart';

class CategoryItem extends BaseItem {
  CategoryItem({
    required Category category,
    required VoidCallback onTap,
    required VoidCallback onPressed,
    required VoidCallback onLongPress,
  }) : super(
          name: category.name,
          leading: CircleAvatar(
            child: Text(
              'CT',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            backgroundColor: Colors.orange,
          ),
          onTap: onTap,
          onPressed: onPressed,
          onLongPress: onLongPress,
        );
}
