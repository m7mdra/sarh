import 'package:flutter/material.dart';

class RelativeAlign extends StatelessWidget {
  final ALIGN alignment;
  final Widget child;

  const RelativeAlign({Key key, this.alignment, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: child,
      alignment: alignment == ALIGN.End
          ? currentLocale(context)
              ? Alignment.centerLeft
              : Alignment.centerRight
          : currentLocale(context)
              ? Alignment.centerRight
              : Alignment.centerLeft,
    );
  }

  bool currentLocale(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }
}

enum ALIGN { Start, End }
