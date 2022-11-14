import 'package:flutter/material.dart';
import '../style/palette.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.fontSize,
      this.onTap,
      this.textColor,
      required this.buttonRectangle,
      required this.widget});
  final double fontSize;
  final VoidCallback? onTap;
  final Color? textColor;
  final bool buttonRectangle;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          if (buttonRectangle) Image.asset("assets/images/bar.png"),
          DefaultTextStyle(
            style: TextStyle(
              fontFamily: 'Permanent Marker',
              fontSize: fontSize,
              color: onTap != null ? textColor : Palette.ink,
            ),
            child: widget,
          )
        ],
      ),
    );
  }
}
