import 'package:flutter/material.dart';
import 'package:fms/common_ui/utils/text_style/common_text_style.dart';

import '../../utils/colors/common_colors.dart';

class PrimaryButtonTextAndIcon extends StatelessWidget {
  final Function() onTap;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double? customHeight;
  final double? fontSize;
  final double? horizontalPadding;
  final Widget? icon;
  final double? verticalPadding;
  final double? customWidth;
  final double borderRadius;
  final bool isActive;
  final Color? borderColor;

  const PrimaryButtonTextAndIcon(
      {Key? key,
      required this.onTap,
      required this.label,
      required this.isActive,
      this.backgroundColor,
      this.textColor,
      this.customHeight,
      this.icon,
      this.fontSize = 16,
      this.borderRadius = 8,
      this.horizontalPadding,
      this.verticalPadding,
      this.customWidth,
      this.borderColor})
      : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //     color: isActive
  //         ? backgroundColor ?? CommonColors.blueD81
  //         : CommonColors.greyB4,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(borderRadius),
  //       side: BorderSide(
  //         color: borderColor == null ? Colors.transparent : CommonColors.blueD0,
  //         width: 1,
  //       ),
  //     ),
  //     child: InkWell(
  //       onTap: () {
  //         if (isActive) {
  //           onTap();
  //         }
  //       },
  //       borderRadius: const BorderRadius.all(
  //         Radius.circular(
  //           8,
  //         ),
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(
  //           horizontal: horizontalPadding ?? 12,
  //           vertical: verticalPadding ?? 6,
  //         ),
  //         child: SizedBox(
  //           height: customHeight ?? 36,
  //           width: customWidth,
  //           child: Center(
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   label,
  //                   style: CommonTypography.inter16.copyWith(
  //                       color: isActive
  //                           ? textColor ?? Colors.white
  //                           : CommonColors.grey88,
  //                       fontSize: fontSize),
  //                 ),
  //                 const SizedBox(width: 6),
  //                 Visibility(
  //                     visible: icon != null,
  //                     child: icon ?? const SizedBox.shrink()),
  //                 Visibility(
  //                     visible: icon != null,
  //                     child: const SizedBox(
  //                           width: 8,
  //                         ) ??
  //                         const SizedBox.shrink()),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive
          ? backgroundColor ?? CommonColors.blue9F
          : CommonColors.greyB4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          color: borderColor == null ? Colors.transparent : CommonColors.blueB5,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          if (isActive) {
            onTap();
          }
        },
        borderRadius: const BorderRadius.all(
          Radius.circular(
            4,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 36,
            vertical: verticalPadding ?? 6,
          ),
          child: SizedBox(
            height: customHeight ?? 36,
            width: customWidth,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: CommonTypography.roboto16.copyWith(
                        color: isActive
                            ? textColor ?? Colors.white
                            : CommonColors.grey88,
                        fontSize: fontSize),
                  ),
                  const SizedBox(width: 6),
                  Visibility(
                      visible: icon != null,
                      child: icon ?? const SizedBox.shrink()),
                  Visibility(
                      visible: icon != null,
                      child: const SizedBox(
                        width: 8,
                      ) ??
                          const SizedBox.shrink()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
