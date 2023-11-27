import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonIcons {
  static SvgPicture homeIcon =
      defaultSizeAssets('home_icon.svg', color: Colors.black);

  static SvgPicture closeCirlce =
      defaultSizeAssets('close-circle.svg', height: 16, width: 16);

  static SvgPicture defaultSizeAssets(
    String filename, {
    Color? color,
    double width = 24,
    double height = 24,
  }) {
    return SvgPicture.asset(
      getAssetPath(filename),
      color: color,
      width: width,
      height: height,
    );
  }

  static String getAssetPath(String filename) {
    return "assets/icons/$filename";
  }
}
