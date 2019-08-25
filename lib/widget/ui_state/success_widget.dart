import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SuccessWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const SuccessWidget({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.solidCheckSquare,
            color: Colors.green,
            size: 80,
          ),
          Visibility(
              visible: title != null,
              child: Text(title??'',
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontWeight: FontWeight.normal))),
          Visibility(visible: subtitle != null, child: Text(subtitle??'')),
        ],
      ),
    );
  }
}
