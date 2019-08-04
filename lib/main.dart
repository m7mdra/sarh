import 'package:Sarh/page/home/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'i10n/app_localizations.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sarh',
      theme: ThemeData(
        buttonColor: Color(0xff0078ff),
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        iconTheme: IconThemeData(color: Color(0xff5fabf6)),
        primaryColor: Color(0xff0078ff),
      ),
      supportedLocales: [
        const Locale('ar', ''),
        const Locale('en', ''),
      ],      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate

      ],
      home: MainPage(),
    );
  }
}
