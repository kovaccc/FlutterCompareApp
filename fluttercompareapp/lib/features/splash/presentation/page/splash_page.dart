import 'package:flutter/material.dart';
import 'package:fluttercompareapp/common/domain/router/navigation_extensions.dart';
import 'package:fluttercompareapp/features/auth/login/domain/notifiers/auth_notifier.dart';
import 'package:fluttercompareapp/features/auth/register/presentation/register_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  static const routeName = '/splash';

  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    ref.read(authNotifierProvider.notifier).listenAuthChanges();
    _toSignIn(ref);
    super.initState();
  }

  Future<void> _toSignIn(WidgetRef ref) async {
    await Future.delayed(const Duration(seconds: 2), () {});
    ref.pushReplacementNamed(RegisterPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Icon(Icons.area_chart),
          ),
        ],
      ),
    );
  }
}
