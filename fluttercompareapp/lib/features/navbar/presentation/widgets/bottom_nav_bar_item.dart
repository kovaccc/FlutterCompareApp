import 'package:flutter/material.dart';
import 'package:fluttercompareapp/features/devices/presentation/devices_page.dart';
import 'package:fluttercompareapp/features/home/presentation/pages/home_page.dart';

enum BottomNavBarItem {
  home(
    icon: Icons.date_range,
    routeName: HomePage.routeName,
    snakeCaseTitle: '/home',
  ),
  devices(
    icon: Icons.date_range,
    routeName: DevicesPage.routeName,
    snakeCaseTitle: '/devices',
  );

  const BottomNavBarItem({
    required this.icon,
    required this.routeName,
    required this.snakeCaseTitle,
  });

  final IconData icon;
  final String routeName;
  final String snakeCaseTitle;

  String get title {
    switch (this) {
      case BottomNavBarItem.home:
        return 'home';
      case BottomNavBarItem.devices:
        return 'devices';
      default:
        return '';
    }
  }
}
