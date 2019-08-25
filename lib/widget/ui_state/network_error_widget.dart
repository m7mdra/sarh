import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NetworkErrorWidget({Key key, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(
            height: 8,
          ),
          Text(
            'No Active internet connection',
            style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 4,
          ),
          Text('Have you tried to restart the router? :)'),
          SizedBox(
            height: 4,
          ),
          OutlineButton(onPressed: onRetry,child: Text('Retry'),)
        ],
      ),
    );
  }
}
