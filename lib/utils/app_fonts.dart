import 'package:flutter/material.dart';

import 'color.dart';

class AppFontsStyle {
  static String fontFamily = 'Euclid Circular A';
  static double headingFontSize22 = 22.0;
  static double headingFontSize20 = 20.0;
  static double titleFontSize16 = 16.0;
  static double titleFontSize18 = 18.0;
  static double titleNormalSize14 = 14.0;
  static double textCaptionSize12 = 12.0;

  static Widget getAppTextView(text, {size, color, textAlign}) {
    final textSize = size == null ? null : double.parse(size.toString());
    return Text(text,
        textAlign: textAlign ?? TextAlign.left,
        style: TextStyle(
          fontFamily: AppFontsStyle.fontFamily,
          color: color ?? Pallet.textColor,
          fontSize: textSize ?? AppFontsStyle.titleNormalSize14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ));
  }

  static Widget getAppTextViewBold(text, {size, color, textAlign}) {
    final textSize = size == null ? null : double.parse(size.toString());
    return Text(text,
        textAlign: textAlign ?? TextAlign.left,
        style: TextStyle(
          fontFamily: AppFontsStyle.fontFamily,
          color: color ?? Pallet.textColor,
          fontSize: textSize ?? AppFontsStyle.titleNormalSize14,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
        ));
  }
}
