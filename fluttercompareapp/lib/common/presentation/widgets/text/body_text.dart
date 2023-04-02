import 'package:flutter/material.dart';
import 'package:fluttercompareapp/common/presentation/extensions/build_context_extension.dart';

class BodyText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool isCentered;
  final bool isUnderlined;
  final bool isBold;
  final TextOverflow? textOverflow;

  const BodyText(
    this.text, {
    Key? key,
    this.isCentered = false,
    this.isBold = false,
    this.color,
    this.textOverflow,
    this.isUnderlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.bodyMedium?.copyWith(
        color: color,
        fontWeight: isBold ? FontWeight.w700 : null,
        overflow: textOverflow,
        decoration: isUnderlined ? TextDecoration.underline : null,
      ),
      textAlign: isCentered ? TextAlign.center : null,
    );
  }
}
