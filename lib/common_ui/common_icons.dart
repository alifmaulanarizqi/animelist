import 'dart:ui';

import 'package:flutter_svg/svg.dart';
import 'package:fms/common_ui/utils/colors/common_colors.dart';

class CommonIcons {
  static SvgPicture truckIcon = defaultSizeAssets(
    'truck.svg',
    height: 40,
    width: 40,
    color: CommonColors.white,
  );

  static SvgPicture clipboardList = defaultSizeAssets(
    'clipboard-list.svg',
    height: 40,
    width: 40,
    color: CommonColors.white,
  );

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