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

// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'messages';

  static m0(phoneNumber) =>
      "Please enter the verification code below that we have sent to your phone number ${phoneNumber}";

  static m1(accountType) => "Creating new \'${accountType}\' account";

  static m2(howMany) =>
      "${Intl.plural(howMany, zero: '${howMany} Second', one: '${howMany} Second', few: '${howMany} Seconds', many: '${howMany} Seconds', other: '${howMany} Seconds')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "Account Verification":
            MessageLookupByLibrary.simpleMessage("Account Verification"),
        "Account type": MessageLookupByLibrary.simpleMessage("Account type"),
        "Activity is empty":
            MessageLookupByLibrary.simpleMessage("Activity is empty"),
        "Attach Document":
            MessageLookupByLibrary.simpleMessage("Attach Document"),
        "Attach Image": MessageLookupByLibrary.simpleMessage("Attach Image"),
        "Attach Video": MessageLookupByLibrary.simpleMessage("Attach Video"),
        "Attach file": MessageLookupByLibrary.simpleMessage("Attach file"),
        "Attachments": MessageLookupByLibrary.simpleMessage("Attachments"),
        "Camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "Choose activity":
            MessageLookupByLibrary.simpleMessage("Choose activity"),
        "Choose request method":
            MessageLookupByLibrary.simpleMessage("Choose request method"),
        "Choose the activity":
            MessageLookupByLibrary.simpleMessage("Choose the activity"),
        "City is not selected":
            MessageLookupByLibrary.simpleMessage("City is not selected"),
        "Confirm Password":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "Create new": MessageLookupByLibrary.simpleMessage("Create new"),
        "Email address": MessageLookupByLibrary.simpleMessage("Email address"),
        "Email field is empty":
            MessageLookupByLibrary.simpleMessage("Email field is empty"),
        "Enter Password first":
            MessageLookupByLibrary.simpleMessage("Enter Password first"),
        "Enter a valid email address":
            MessageLookupByLibrary.simpleMessage("Enter a valid email address"),
        "Enter username or email address first":
            MessageLookupByLibrary.simpleMessage(
                "Enter username or email address first"),
        "Error occurred":
            MessageLookupByLibrary.simpleMessage("Error occurred"),
        "Explain what you need from the service provider":
            MessageLookupByLibrary.simpleMessage(
                "Explain what you need from the service provider"),
        "Failed to verfiy account.":
            MessageLookupByLibrary.simpleMessage("Failed to verfiy account."),
        "Favorite": MessageLookupByLibrary.simpleMessage("Favorite"),
        "Forgot my password":
            MessageLookupByLibrary.simpleMessage("Forgot my password"),
        "Full name": MessageLookupByLibrary.simpleMessage("Full name"),
        "Gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "I Already have an account":
            MessageLookupByLibrary.simpleMessage("I Already have an account"),
        "I Dont have an account":
            MessageLookupByLibrary.simpleMessage("I Dont have an account"),
        "Invalid Verification code, try again or request new code.":
            MessageLookupByLibrary.simpleMessage(
                "Invalid Verification code, try again or request new code."),
        "Login": MessageLookupByLibrary.simpleMessage("Login"),
        "Login information is not valid, try again":
            MessageLookupByLibrary.simpleMessage(
                "Login information is not valid, try again"),
        "Name field is empty":
            MessageLookupByLibrary.simpleMessage("Name field is empty"),
        "New post": MessageLookupByLibrary.simpleMessage("New post"),
        "Next": MessageLookupByLibrary.simpleMessage("Next"),
        "No active internet connection": MessageLookupByLibrary.simpleMessage(
            "No active internet connection"),
        "No data found.":
            MessageLookupByLibrary.simpleMessage("No data found."),
        "PDF format only allowed":
            MessageLookupByLibrary.simpleMessage("PDF format only allowed"),
        "Password": MessageLookupByLibrary.simpleMessage("Password"),
        "Personal account":
            MessageLookupByLibrary.simpleMessage("Personal account"),
        "Phone number": MessageLookupByLibrary.simpleMessage("Phone number"),
        "Phone number field is empty":
            MessageLookupByLibrary.simpleMessage("Phone number field is empty"),
        "Phone number invalid":
            MessageLookupByLibrary.simpleMessage("Phone number invalid"),
        "Please fill the fields":
            MessageLookupByLibrary.simpleMessage("Please fill the fields"),
        "Please wait while attempting to log you in.":
            MessageLookupByLibrary.simpleMessage(
                "Please wait while attempting to log you in."),
        "Please wait while we verfiy your account.":
            MessageLookupByLibrary.simpleMessage(
                "Please wait while we verfiy your account."),
        "Quotation details":
            MessageLookupByLibrary.simpleMessage("Quotation details"),
        "Quotation subject":
            MessageLookupByLibrary.simpleMessage("Quotation subject"),
        "Quotation subject is empty":
            MessageLookupByLibrary.simpleMessage("Quotation subject is empty"),
        "Random": MessageLookupByLibrary.simpleMessage("Random"),
        "Recommendation":
            MessageLookupByLibrary.simpleMessage("Recommendation"),
        "Register": MessageLookupByLibrary.simpleMessage("Register"),
        "Register a service provider":
            MessageLookupByLibrary.simpleMessage("Register a service provider"),
        "Register a user":
            MessageLookupByLibrary.simpleMessage("Register a user"),
        "Request Quotations":
            MessageLookupByLibrary.simpleMessage("Request Quotations"),
        "Request method":
            MessageLookupByLibrary.simpleMessage("Request method"),
        "Request timed out.":
            MessageLookupByLibrary.simpleMessage("Request timed out."),
        "Resending verification code.": MessageLookupByLibrary.simpleMessage(
            "Resending verification code."),
        "Retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "Select a city": MessageLookupByLibrary.simpleMessage("Select a city"),
        "Select method to pick image":
            MessageLookupByLibrary.simpleMessage("Select method to pick image"),
        "Select your account type":
            MessageLookupByLibrary.simpleMessage("Select your account type"),
        "Send again": MessageLookupByLibrary.simpleMessage("Send again"),
        "Service Provider":
            MessageLookupByLibrary.simpleMessage("Service Provider"),
        "Service provider Name":
            MessageLookupByLibrary.simpleMessage("Service provider Name"),
        "Sign up": MessageLookupByLibrary.simpleMessage("Sign up"),
        "Sing in": MessageLookupByLibrary.simpleMessage("Sing in"),
        "Submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "Thats all we know for now.":
            MessageLookupByLibrary.simpleMessage("Thats all we know for now."),
        "Try to change current wifi or contact your ISP":
            MessageLookupByLibrary.simpleMessage(
                "Try to change current wifi or contact your ISP"),
        "Try to check after few minutes": MessageLookupByLibrary.simpleMessage(
            "Try to check after few minutes"),
        "Username": MessageLookupByLibrary.simpleMessage("Username"),
        "Username or Email":
            MessageLookupByLibrary.simpleMessage("Username or Email"),
        "Username or email address":
            MessageLookupByLibrary.simpleMessage("Username or email address"),
        "Verification code was request successfully":
            MessageLookupByLibrary.simpleMessage(
                "Verification code was request successfully"),
        "Verify": MessageLookupByLibrary.simpleMessage("Verify"),
        "Will be sent randomly to service to service providers in this activity":
            MessageLookupByLibrary.simpleMessage(
                "Will be sent randomly to service to service providers in this activity"),
        "Will be sent to high rated service providers":
            MessageLookupByLibrary.simpleMessage(
                "Will be sent to high rated service providers"),
        "Will be sent to your favorite service providers":
            MessageLookupByLibrary.simpleMessage(
                "Will be sent to your favorite service providers"),
        "accountVerificationMessage": m0,
        "creatingAccountProgressTitle": m1,
        "enter the quotation subject":
            MessageLookupByLibrary.simpleMessage("enter the quotation subject"),
        "password field is empty":
            MessageLookupByLibrary.simpleMessage("password field is empty"),
        "seconds": m2
      };
}
