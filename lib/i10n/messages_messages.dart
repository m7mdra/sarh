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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "Create new" : MessageLookupByLibrary.simpleMessage("Create new"),
    "Forgot my password" : MessageLookupByLibrary.simpleMessage("Forgot my password"),
    "I Dont have an account" : MessageLookupByLibrary.simpleMessage("I Dont have an account"),
    "Login" : MessageLookupByLibrary.simpleMessage("Login"),
    "Password" : MessageLookupByLibrary.simpleMessage("Password"),
    "Sing in" : MessageLookupByLibrary.simpleMessage("Sing in"),
    "Username or Email" : MessageLookupByLibrary.simpleMessage("Username or Email")
  };
}
