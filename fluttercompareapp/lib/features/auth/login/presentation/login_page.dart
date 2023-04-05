//ignore_for_file: always_use_package_imports

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttercompareapp/common/domain/router/navigation_extensions.dart';
import 'package:fluttercompareapp/common/presentation/app_sizes.dart';
import 'package:fluttercompareapp/common/presentation/extensions/build_context_extension.dart';
import 'package:fluttercompareapp/common/presentation/extensions/form_key_extensions.dart';
import 'package:fluttercompareapp/common/presentation/widgets/main_scaffold.dart';
import 'package:fluttercompareapp/features/auth/login/domain/notifiers/login_notifier.dart';
import 'package:fluttercompareapp/features/auth/login/forms/login_form.dart';
import 'package:fluttercompareapp/features/navbar/presentation/pages/nav_bar.dart';
import 'package:fluttercompareapp/generated/l10n.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isNextEnabled = StateProvider<bool>((_) => false);

class LoginPage extends ConsumerWidget {
  static const routeName = '/login-page';

  final formKey = GlobalKey<FormBuilderState>();

  LoginPage({super.key});

  void _refreshNextEnabled(WidgetRef ref) => WidgetsBinding.instance
      .addPostFrameCallback((_) => ref.read(isNextEnabled.notifier).state =
          formKey.currentState?.isValid ?? false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginNotifierProvider, (previous, next) {});

    ref.listen(loginNotifierProvider, (previous, next) {
      next.maybeMap(
        data: (data) {

          ref.pushReplacementNamed(NavBar.routeName);
        },
        error: (data) {
          context.showSnackBar(data.failure.title);
        },
        orElse: () {},
      );
    });
    return MainScaffold(
      appBar: AppBar(
        title: Text(S.of(context).log_in),
      ),
      body: Center(
        child: FormBuilder(
          key: formKey,
          onChanged: () => _refreshNextEnabled(ref),
          child: Column(
            children: [
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: LoginForm.email,
                decoration: InputDecoration(hintText: S.current.email),
                validator: FormBuilderValidators.compose([
                  LoginForm.isRequired(),
                ]),
              ),
              const SizedBox(
                height: AppSizes.normalSpacing,
              ),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: LoginForm.password,
                decoration: InputDecoration(hintText: S.current.password),
                validator: FormBuilderValidators.compose([
                  LoginForm.isRequired(),
                ]),
              ),
              const SizedBox(
                height: AppSizes.normalSpacing,
              ),
              RichText(
                text: TextSpan(
                  text: S.current.do_not_have_account_sign_up,
                  style: Theme.of(context).textTheme.bodyMedium,
                  recognizer: TapGestureRecognizer()..onTap = () => ref.pop(),
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => formKey.submitForm(
                  (formMap) =>
                      ref.read(loginNotifierProvider.notifier).login(formMap),
                ),
                child: Text(S.current.log_in),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
