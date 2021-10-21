
import 'dart:io';

import 'package:bawo/utils/constant.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetDeviceInfo extends StatefulWidget {
  const GetDeviceInfo({Key? key}) : super(key: key);

  @override
  _GetDeviceInfoState createState() => _GetDeviceInfoState();
}

class _GetDeviceInfoState extends State<GetDeviceInfo> {
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();

  String? deviceBrand;
  String? deviceModel;
  String? deviceId;

  @override
  void initState() {
    _deviceDetails();
    super.initState();
  }

  Future<void>_deviceDetails() async{
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceModel = build.model;
          deviceBrand = build.brand;
          deviceId = build.androidId;
          print('get Android deviceModel: $deviceModel');
          print('get Android deviceBrand: $deviceBrand');
          print('get Android deviceId: $deviceId');
          sharedPreference.setDeviceId(deviceId!);
          sharedPreference.setDeviceModel(deviceModel!);
          sharedPreference.setDeviceBrand(deviceBrand!);
        });
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        print('get platform data...: $data');
        setState(() {
          deviceModel = data.model;
          deviceBrand = data.name;
          deviceId = data.identifierForVendor;
          print('get platform iOSModel...: $deviceModel');
          print('get platform iOSName...: $deviceBrand');
          print('get platform iOSId...: $deviceId');
          sharedPreference.setDeviceId(deviceId!);
          sharedPreference.setDeviceModel(deviceModel!);
          sharedPreference.setDeviceBrand(deviceBrand!);
        });//UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container();
  }

}
