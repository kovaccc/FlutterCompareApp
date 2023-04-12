// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "already_have_account_log_in": MessageLookupByLibrary.simpleMessage(
            "Already have account? Log in!"),
        "do_not_have_account_sign_up": MessageLookupByLibrary.simpleMessage(
            "Do not have account? Sign up!"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "log_in": MessageLookupByLibrary.simpleMessage("Login"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "permission_denied": MessageLookupByLibrary.simpleMessage(
            "Permission has been denied, please enable it in device settings"),
        "photo_detail": MessageLookupByLibrary.simpleMessage("Photo detail"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "unknown_error_occurred":
            MessageLookupByLibrary.simpleMessage("Unknown error occurred")
      };
}
