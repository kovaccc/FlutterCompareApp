//ignore_for_file: always_use_package_imports

import 'package:form_builder_validators/form_builder_validators.dart';

abstract class LoginForm {
  static const email = 'email';
  static const password = 'password';

  static String? Function(T?) isRequired<T>() =>
      FormBuilderValidators.required(errorText: 'This field is mandatory');
}
