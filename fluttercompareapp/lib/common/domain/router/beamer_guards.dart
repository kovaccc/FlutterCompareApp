import 'package:beamer/beamer.dart';
import 'package:fluttercompareapp/common/domain/router/base_router.dart';
import 'package:fluttercompareapp/features/auth/login/domain/notifiers/auth_notifier.dart';
import 'package:fluttercompareapp/features/auth/login/presentation/login_page.dart';
import 'package:fluttercompareapp/features/auth/register/presentation/register_page.dart';
import 'package:fluttercompareapp/features/devices/presentation/devices_page.dart';
import 'package:fluttercompareapp/features/home/presentation/pages/home_page.dart';
import 'package:fluttercompareapp/features/navbar/presentation/pages/nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<BeamGuard> beamerGuards(ProviderRef<BaseRouter> ref) {
  return [
    BeamGuard(
      pathPatterns: [
        RegisterPage.routeName,
        LoginPage.routeName,
      ],
      check: (context, location) => !_isLoggedIn(ref),
      beamToNamed: (_, __) => NavBar.routeName,
    ),
    BeamGuard(
      pathPatterns: ['${NavBar.routeName}*'],
      check: (context, location) => _isLoggedIn(ref),
      beamToNamed: (_, __) => RegisterPage.routeName,
    ),
  ];
}

bool _isLoggedIn(ProviderRef<BaseRouter> ref) {
  return ref.read(authNotifierProvider).maybeMap(
        orElse: () => false,
        data: (data) {
          if (data.data) {
            return true;
          } else {
            return false;
          }
        },
      );
}
