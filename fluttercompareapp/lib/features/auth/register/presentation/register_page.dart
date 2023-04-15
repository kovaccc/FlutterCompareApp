//ignore_for_file: always_use_package_imports

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttercompareapp/common/domain/router/navigation_extensions.dart';
import 'package:fluttercompareapp/common/presentation/app_sizes.dart';
import 'package:fluttercompareapp/common/presentation/extensions/build_context_extension.dart';
import 'package:fluttercompareapp/common/presentation/extensions/form_key_extensions.dart';
import 'package:fluttercompareapp/common/presentation/widgets/main_scaffold.dart';
import 'package:fluttercompareapp/features/auth/login/presentation/login_page.dart';
import 'package:fluttercompareapp/features/auth/register/domain/notifiers/register_notifier.dart';
import 'package:fluttercompareapp/features/auth/register/forms/register_form.dart';
import 'package:fluttercompareapp/features/home/presentation/pages/home_page.dart';
import 'package:fluttercompareapp/generated/l10n.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isNextEnabled = StateProvider<bool>((_) => false);

class RegisterPage extends ConsumerWidget {
  static const routeName = '/register-page';

  final formKey = GlobalKey<FormBuilderState>();

  RegisterPage({super.key});

  void _refreshNextEnabled(WidgetRef ref) => WidgetsBinding.instance
      .addPostFrameCallback((_) => ref.read(isNextEnabled.notifier).state =
          formKey.currentState?.isValid ?? false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(registerNotifierProvider, (previous, next) {});

    ref.listen(registerNotifierProvider, (previous, next) {
      next.maybeMap(
        data: (data) {
          ref.pushReplacementNamed(HomePage.routeName);
        },
        error: (data) {
          context.showSnackBar(data.failure.title);
        },
        orElse: () {},
      );
    });
    return MainScaffold(
      appBar: AppBar(
        title: Text(S.of(context).register),
      ),
      body: Center(
        child: FormBuilder(
          key: formKey,
          onChanged: () => _refreshNextEnabled(ref),
          child: Column(
            children: [
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: RegisterForm.email,
                decoration: InputDecoration(hintText: S.current.email),
                validator: FormBuilderValidators.compose([
                  RegisterForm.isRequired(),
                ]),
              ),
              const SizedBox(
                height: AppSizes.normalSpacing,
              ),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: RegisterForm.password,
                decoration: InputDecoration(hintText: S.current.password),
                validator: FormBuilderValidators.compose([
                  RegisterForm.isRequired(),
                ]),
              ),
              const SizedBox(
                height: AppSizes.normalSpacing,
              ),
              RichText(
                text: TextSpan(
                  text: S.current.already_have_account_log_in,
                  style: Theme.of(context).textTheme.bodyMedium,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => ref.pushNamed(LoginPage.routeName),
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => formKey.submitForm(
                  (formMap) => ref
                      .read(registerNotifierProvider.notifier)
                      .register(formMap),
                ),
                child: Text(S.current.register),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
