import 'package:flutter/material.dart';

String currentLanguage(BuildContext context) {
  return Localizations.localeOf(context).languageCode;
}
