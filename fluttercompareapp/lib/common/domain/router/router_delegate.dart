import 'package:beamer/beamer.dart';
import 'package:fluttercompareapp/common/domain/router/beamer_guards.dart';
import 'package:fluttercompareapp/features/auth/login/presentation/login_page.dart';
import 'package:fluttercompareapp/features/auth/register/presentation/register_page.dart';
import 'package:fluttercompareapp/features/home/presentation/pages/home_page.dart';
import 'package:fluttercompareapp/features/navbar/presentation/pages/nav_bar.dart';

final routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/': (context, state, data) => const NavBar(),
      HomePage.routeName: (context, state, data) => const HomePage(),
      LoginPage.routeName: (context, state, data) => LoginPage(),
      RegisterPage.routeName: (context, state, data) => RegisterPage(),
      NavBar.routeName: (context, state, data) => const NavBar(),
    },
  ),
);
