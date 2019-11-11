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

  String get register => Intl.message('Register');

  String get username => Intl.message('Username');

  String get emailAddress => Intl.message('Email address');

  String get fullName => Intl.message('Full name');

  String get confirmPassword => Intl.message('Confirm Password');

  String get accountType => Intl.message('Account type');

  String get signupButton => Intl.message('Sign up');

  String get iAlreadyHaveAccount => Intl.message("I Already have an account");

  String get nextButton => Intl.message('Next');

  String get loginLoadingDialogMessage =>
      Intl.message('Please wait while attempting to log you in.');

  String get logoutLoadingDialogMessage =>
      Intl.message('Please wait while attempting to logout.');

  String get noNetworkError => Intl.message('No active internet connection');

  String get retryButton => Intl.message('Retry');

  String get invalidLoginCredentials =>
      Intl.message('Login information is not valid, try again');

  String get invalidEmailValidationError =>
      Intl.message('Enter a valid email address');

  String get emptyEmailValidationError =>
      Intl.message('Enter username or email address first');

  String get emptyPasswordValidationError =>
      Intl.message('Enter Password first');

  String get userIdentifierFieldHint =>
      Intl.message('Username or email address');

  String get selectAccountType => Intl.message('Select your account type');

  String get personalAccountType => Intl.message('Personal account');

  String get serviceProviderAccountType => Intl.message('Service Provider');

  String get registerUser => Intl.message('Register a user');

  String get registerServiceProvider =>
      Intl.message('Register a service provider');

  String get phoneNumberFieldHint => Intl.message('Phone number');

  String get cityFieldHint => Intl.message('Select a city');

  String get serviceProviderName => Intl.message('Service provider Name');

  String get accountVerificationPageTitle =>
      Intl.message('Account Verification');

  String accountVerificationMessage(String phoneNumber) => Intl.message(
        'Please enter the verification code below that we have sent to your phone number $phoneNumber',
        args: [phoneNumber],
        name: 'accountVerificationMessage',
      );

  String get sendAgainButton => Intl.message('Send again');

  String get verifyButton => Intl.message('Verify');

  String get nameFieldIsEmpty => Intl.message('Name field is empty');

  String get emailFieldEmpty => Intl.message('Email field is empty');

  String get phoneNumberFieldEmpty =>
      Intl.message('Phone number field is empty');

  String get phoneNumberFieldInvalid => Intl.message('Phone number invalid');

  String get passwordFieldEmpty => Intl.message('password field is empty');

  String get cityFieldEmpty => Intl.message('City is not selected');

  String get pleaseFillAllTheFields => Intl.message('Please fill the fields');

  String get attachImage => Intl.message('Attach Image');

  String get attachVideo => Intl.message('Attach Video');

  String get attachDocument => Intl.message('Attach Document');

  String get attachDocumentOnlyPdf => Intl.message('PDF format only allowed');

  String get imagePickerDialogTitle =>
      Intl.message('Select method to pick image');

  String get camera => Intl.message('Camera');

  String get gallery => Intl.message('Gallery');

  String get requestQuotations => Intl.message('Request Quotations');

  String get activity => Intl.message('Choose the activity');

  String get activityHint => Intl.message('Choose activity');

  String get requestMethod => Intl.message('Choose request method');

  String get requestMethodHint => Intl.message('Request method');

  String get quotationSubject => Intl.message('Quotation subject');

  String get quotationSubjectHint =>
      Intl.message('enter the quotation subject');

  String get quotationDetails => Intl.message('Quotation details');

  String get quotationDetailsHint =>
      Intl.message('Explain what you need from the service provider');

  String get attachments => Intl.message('Attachments');

  String get submitButton => Intl.message('Submit');

  String get attachFileButton => Intl.message('Attach file');

  String get favoriteRequestMethod => Intl.message('Favorite');

  String get favoriteRequestMethodHint =>
      Intl.message('Will be sent to your favorite service providers');

  String get randomRequestMethod => Intl.message('Random');

  String get randomRequestMethodHint => Intl.message(
      'Will be sent randomly to service to service providers in this activity');

  String get recommendationRequestMethod => Intl.message('Recommendation');

  String get recommendationRequestMethodHint =>
      Intl.message('Will be sent to high rated service providers');

  String get activityFieldEmptyError => Intl.message('Activity is empty');

  String get quotationSubjectFieldEmptyError =>
      Intl.message('Quotation subject is empty');

  String get newPost => Intl.message('New post');

  String get verifyAccountProgressDialogTitle =>
      Intl.message('Please wait while we verfiy your account.');

  String get resendCodeProgressDialogTitle =>
      Intl.message('Resending verification code.');

  String get verifyFailed => Intl.message('Failed to verfiy account.');

  String get invalidVerificationCode =>
      Intl.message('Invalid Verification code, try again or request new code.');

  String get verificationCodeRequest =>
      Intl.message('Verification code was request successfully');

  String get requestTimeout => Intl.message('Request timed out.');

  String seconds(int howMany) => Intl.plural(howMany,
      zero: '$howMany Second',
      one: '$howMany Second',
      few: '$howMany Seconds',
      many: '$howMany Seconds',
      other: '$howMany Seconds',
      args: [howMany],
      name: 'seconds');

  String creatingAccountProgressTitle(String accountType) =>
      Intl.message("Creating new '$accountType' account",
          name: 'creatingAccountProgressTitle', args: [accountType]);

  String get errorDialogTitle => Intl.message('Error occurred');

  String get noDataFound => Intl.message('No data found.');

  String get noDataFoundSubtitle =>
      Intl.message('Try to check after few minutes');

  String get errorOccurredSubtitle =>
      Intl.message('Thats all we know for now.');

  String get noInternetConnection =>
      Intl.message('No active internet connection');

  String get noInternetConnectionSubtitle =>
      Intl.message('Try to change current wifi or contact your ISP');
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
