import 'dart:io';

import 'package:bawo/utils/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BawoAppButton extends StatelessWidget {
  Function()? onPressed;
  String title;
  Color disabledColor;
  Color titleColor;
  Color enabledColor;
  bool enabled;
  Icon? icon;
  bool? showFaceIdIcons;

  BawoAppButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.disabledColor,
      required this.titleColor,
      required this.enabledColor,
      required this.enabled,
      this.icon,
      this.showFaceIdIcons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(
              vertical: 2.5,
              horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: enabled ? enabledColor : disabledColor,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showFaceIdIcons != null
                    ? Container(
                    padding: EdgeInsets.only(right: 12),
                    child: Platform.isAndroid ? SvgPicture.asset("assets/images/ic_finger_print.svg")
                        : SvgPicture.asset("assets/images/ic_faceid.svg")
                )
                : Container(),
                icon != null
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: icon)
                    : Container(),
                AppFontsStyle.getAppTextViewBold(title, size:AppFontsStyle.titleFontSize16, color: titleColor)

              ],
            ),
          ),
        ),
        onPressed: enabled ? onPressed : null);
  }
}
