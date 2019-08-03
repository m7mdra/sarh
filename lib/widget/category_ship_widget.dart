import 'package:flutter/material.dart';

class CategoryShip extends StatelessWidget {
  final String category;

  const CategoryShip({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Chip(
        padding: const EdgeInsets.all(2.0),

        clipBehavior: Clip.antiAlias,
        label: Text(category),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: Colors.grey.withAlpha(40))),
        backgroundColor: Colors.white30,
        elevation: 1,
      ),
    );
  }
}
