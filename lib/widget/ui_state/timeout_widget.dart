/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

import 'package:Sarh/i10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimeoutWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const TimeoutWidget({Key key, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //TODO add translation

          SizedBox(
            height: 8,
          ),
          Text('Operation timeout',
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontWeight: FontWeight.normal)),
          SizedBox(
            height: 4,
          ),
          Text('This took longer than we expected, try again'),
          SizedBox(
            height: 4,
          ),
          OutlineButton(
            onPressed: onRetry,
            child: Text(AppLocalizations.of(context).retryButton),
          )
        ],
      ),
    );
  }
}
