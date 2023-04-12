// ignore_for_file: always_use_package_imports

import 'package:beamer/beamer.dart';
import 'package:fluttercompareapp/features/photo_detail/presentation/photo_detail_page.dart';
import 'package:fluttercompareapp/features/splash/presentation/page/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttercompareapp/common/domain/router/beamer_guards.dart';
import 'package:fluttercompareapp/features/auth/login/presentation/login_page.dart';
import 'package:fluttercompareapp/features/auth/register/presentation/register_page.dart';
import 'package:fluttercompareapp/features/home/presentation/pages/home_page.dart';
import 'package:fluttercompareapp/features/navbar/presentation/pages/nav_bar.dart';

import '../router/base_router.dart';

final baseRouterProvider = Provider<BaseRouter>((ref) {
  return BeamerRouter(
    routerDelegate: BeamerDelegate(
      initialPath: SplashPage.routeName,
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '/': (context, state, data) => RegisterPage(),
          SplashPage.routeName: (context, state, data) => const SplashPage(),
          HomePage.routeName: (context, state, data) => const HomePage(),
          LoginPage.routeName: (context, state, data) => LoginPage(),
          RegisterPage.routeName: (context, state, data) => RegisterPage(),
          NavBar.routeName: (context, state, data) => const NavBar(),
          PhotoDetailPage.routeName: (context, state, data) =>
              PhotoDetailPage(imageUrl: data as String),
        },
      ),
      guards: beamerGuards(ref),
    ),
    routeInformationParser: BeamerParser(),
  );
});
