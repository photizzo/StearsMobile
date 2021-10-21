// ignore: import_of_legacy_library_into_null_safe
import 'package:bawo/utils/app_fonts.dart';
import 'package:bawo/utils/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/svg.dart';

class CircleImageFromFile extends StatelessWidget {
  final fileName;

  CircleImageFromFile(this.fileName);

  @override
  Widget build(BuildContext context) {
    double _size = 120.0;

    return new Container(
      height: _size,
      width: _size,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0x33A6A6A6)),
        // image: new Image.asset(_image.)
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(_size),
          child: new Image.file(fileName)),
    );
  }
}

class CircleImageFromNetwork extends StatelessWidget {
  final url;
  final placeholder;
  final errorHolder;
  double? size;
  Color? borderColor;

  CircleImageFromNetwork(this.url, this.placeholder, this.errorHolder, {size, borderColor}) {
    this.size = double.parse(size.toString());
    this.borderColor = borderColor;
  }

  @override
  Widget build(BuildContext context) {
    double _size = size ?? 120.0;

    return new Container(
      height: _size,
      width: _size,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor ?? Color(0x33A6A6A6)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_size),
        child: CachedNetworkImage(
          height: 100,
          width: 100,
          fit: BoxFit.contain,
          imageUrl: url,
          placeholder: (context, url) => SvgPicture.asset(placeholder),
          errorWidget: (context, url, error) => SvgPicture.asset(errorHolder),
        ),
      ),
    );
  }
}

class CircleProfileImageText extends StatelessWidget {
  final text;
  double? size;

  CircleProfileImageText(this.text, {size}) {
    this.size = double.parse(size.toString());
  }

  @override
  Widget build(BuildContext context) {
    double _size = size ?? 120.0;

    return new Container(
      height: _size,
      width: _size,
      decoration:
          new BoxDecoration(shape: BoxShape.circle, color: Pallet.colorPrimaryDark),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_size),
        child: Center(
          child: AppFontsStyle.getAppTextViewBold(text,
              color: Pallet.colorWhite, size: 20.0),
        ),
      ),
    );
  }
}
