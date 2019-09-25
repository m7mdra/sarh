import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Sarh/i10n/app_localizations.dart';

class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NetworkErrorWidget({Key key, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(
            height: 8,
          ),
          Text(
            AppLocalizations.of(context).noInternetConnection,
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 4,
          ),
          Text(AppLocalizations.of(context).noInternetConnectionSubtitle),
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
