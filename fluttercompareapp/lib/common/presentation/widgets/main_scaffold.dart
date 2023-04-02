import 'package:flutter/material.dart';
import 'package:fluttercompareapp/common/presentation/app_sizes.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.padding = const EdgeInsets.symmetric(
      vertical: AppSizes.normalSpacing,
      horizontal: AppSizes.normalSpacing,
    ),
  });

  final Widget body;
  final AppBar? appBar;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: body,
        ),
      ),
    );
  }
}
