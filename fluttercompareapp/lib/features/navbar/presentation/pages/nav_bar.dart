import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:fluttercompareapp/features/auth/login/domain/notifiers/auth_notifier.dart';
import 'package:fluttercompareapp/features/devices/presentation/devices_page.dart';
import 'package:fluttercompareapp/features/home/presentation/pages/home_page.dart';
import 'package:fluttercompareapp/features/navbar/presentation/widgets/bottom_nav_bar_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class NavBar extends ConsumerStatefulWidget {
  static const routeName = '/nav_bar';

  const NavBar({Key? key}) : super(key: key);

  @override
  ConsumerState<NavBar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends ConsumerState<NavBar> {
  int _currentIndex = 0;

  void _navigateTo(index) {
    if (index != _currentIndex) {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authNotifierProvider,
      (_, state) {
        state.maybeMap(
          orElse: () {},
          data: (data) {
            logInfo('matej1 ${data.data}');
            if (!data.data) {
              Beamer.of(context).update();
            }
          },
        );
      },
    );
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: const [
                HomePage(),
                DevicesPage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          _navigateTo(index);
        },
        destinations: BottomNavBarItem.values
            .map(
              (tab) => NavigationDestination(
                icon: Icon(tab.icon),
                label: tab.title,
              ),
            )
            .toList(),
      ),
    );
  }
}
