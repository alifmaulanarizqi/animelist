import 'package:flutter/material.dart';
import '../../utils/colors/common_colors.dart';
import '../../utils/text_style/common_text_style.dart';

class OutlineButtonText extends StatelessWidget {
  final Function() onTap;
  final double? fontSize;
  final double? customHeight;
  final double? customWidth;
  final Color backgroundColor;
  final Color textColor;
  final String label;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool isActive;
  final Color borderColor;

  const OutlineButtonText(
      {Key? key,
      required this.onTap,
      required this.label,
      this.isActive = true,
      this.fontSize = 14,
      this.customHeight,
      this.customWidth,
      this.backgroundColor = Colors.white,
      this.textColor = CommonColors.blueB5,
      this.horizontalPadding,
      this.verticalPadding,
      this.borderColor = CommonColors.blue9F})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isActive) {
          onTap();
        }
      },
      child: Container(
        height: customHeight ?? 47,
        width: customWidth,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 36,
          vertical: verticalPadding ?? 6,
        ),
        decoration: BoxDecoration(
          color: isActive ? backgroundColor : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1.0,
            color: isActive ? borderColor : CommonColors.greyD7,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: CommonTypography.roboto16.copyWith(
              fontSize: fontSize,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
