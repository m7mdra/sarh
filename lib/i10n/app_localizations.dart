import 'dart:ui';

import 'package:Sarh/i10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get login => Intl.message("Login");

  String get userNameOrEmail => Intl.message("Username or Email");

  String get passwordFieldName => Intl.message("Password");

  String get signInButton => Intl.message('Sing in');

  String get forgetMyPasswordButton => Intl.message('Forgot my password');

  String get iDontHaveAnAccount => Intl.message('I Dont have an account');

  String get createNew => Intl.message('Create new');
  String get register=>Intl.message('Register');
  String get username=>Intl.message('Username');
  String get emailAddress=>Intl.message('Email address');
  String get fullName=>Intl.message('Full name');
  String get confirmPassword=>Intl.message('Confirm Password');
  String get accountType=>Intl.message('Account type');
  String get signupButton=>Intl.message('Sign up');
  String get iAlreadyHaveAccount=>Intl.message("I Already have an account");

  String get nextButton=>Intl.message('Next');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}
