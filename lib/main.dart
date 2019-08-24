import 'package:Sarh/page/home/home_page.dart';
import 'package:Sarh/page/home/main_page.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/page/register/register_page.dart';
import 'package:Sarh/page/splash/splash_page.dart';
import 'package:Sarh/page/verify_account/verify_account_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dependency_provider.dart';
import 'i10n/app_localizations.dart';

void main() {
  DependencyProvider.build();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sarh',
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return SplashPage();
        });
      },
      builder: (context, navigator) {
        return Theme(
            data: ThemeData(

              backgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  brightness: Brightness.dark,
                  color: Color(0xff0078ff),
                  iconTheme: IconThemeData(color: Colors.white)),
              buttonColor: Color(0xff0078ff),
              errorColor: Color(0xffDB0000),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              iconTheme: IconThemeData(color: Color(0xff5fabf6)),
              primaryColor: Color(0xff0078ff),
              fontFamily: Localizations.localeOf(context).languageCode == 'ar'
                  ? 'Segoe UI'
                  : 'Poppins',
            ),
            child: navigator);
      },
      supportedLocales: [
        const Locale('ar', ''),
        const Locale('en', ''),
      ],
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      home: SplashPage(),
    );
  }
}
