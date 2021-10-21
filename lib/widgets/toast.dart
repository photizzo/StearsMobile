import 'package:bawo/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
  msg: message,
  backgroundColor: Pallet.colorBlack,
  // fontSize: 25
  // gravity: ToastGravity.TOP,
  // textColor: Colors.pink
  );
}