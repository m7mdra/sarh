import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BackButtonWidget extends StatefulWidget {
  @override
  _BackButtonWidgetState createState() => _BackButtonWidgetState();
}

class _BackButtonWidgetState extends State<BackButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    var isArabic = myLocale.languageCode == 'ar';
    return FlatButton.icon(
        padding: const EdgeInsets.all(0),
        textColor: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(isArabic
            ? FontAwesomeIcons.chevronRight
            : FontAwesomeIcons.chevronLeft),
        label: Text(MaterialLocalizations.of(context).backButtonTooltip));
  }
}

class BackButtonNoLabel extends StatelessWidget {
  final Color color;

  const BackButtonNoLabel(this.color, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    var isArabic = myLocale.languageCode == 'ar';
    return IconButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        isArabic ? FontAwesomeIcons.chevronRight : FontAwesomeIcons.chevronLeft,
        color: color,
      ),
    );
  }
}
