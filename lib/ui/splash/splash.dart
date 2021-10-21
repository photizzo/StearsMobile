
import 'package:bawo/ui/routes/routes.dart';
import 'package:bawo/utils/change_statusbar_color.dart';
import 'package:bawo/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    changeStatusAndNavBarColor(Pallet.colorPrimaryDark, Pallet.colorRed, true, true);
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
           Navigator.pushReplacementNamed(context, AppRoutes.home);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Center(
                child: SvgPicture.asset(
                  "assets/images/stears_logo.svg",
                  fit: BoxFit.fill,
                  height: 56,
                ),
              )
            ],))
    );
  }
}


