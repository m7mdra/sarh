import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(
            height: 8,
          ),
          Text(
            'No Data found',
            style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 4,
          ),
          Text('Try to check after few minutes'),
          SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
