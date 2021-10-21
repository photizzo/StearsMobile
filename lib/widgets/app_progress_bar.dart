import 'package:bawo/utils/color.dart';
import 'package:flutter/material.dart';

class AppProgressBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Pallet.colorPrimaryDark,
    );
  }
}