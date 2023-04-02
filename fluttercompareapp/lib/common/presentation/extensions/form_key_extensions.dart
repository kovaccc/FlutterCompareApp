import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loggy/loggy.dart';

//ignore: prefer-match-file-name
extension SubmitForm on GlobalKey<FormBuilderState> {
  void submitForm(Function(Map<String, dynamic> formMap) formFunction) {
    if (currentState?.saveAndValidate() ?? false) {
      final formMap = currentState!.value;
      formFunction(formMap);
    } else {
      logDebug('validation failed');
    }
  }
}
