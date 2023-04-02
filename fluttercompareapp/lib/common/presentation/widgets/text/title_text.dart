import 'package:flutter/material.dart';
import 'package:fluttercompareapp/common/presentation/extensions/build_context_extension.dart';

class TitleText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool isCentered;
  final bool isBold;

  const TitleText(
    this.text, {
    Key? key,
    this.isCentered = false,
    this.isBold = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.titleMedium?.copyWith(
        color: color,
        fontWeight: isBold ? FontWeight.w700 : null,
      ),
      textAlign: isCentered ? TextAlign.center : null,
    );
  }
}
