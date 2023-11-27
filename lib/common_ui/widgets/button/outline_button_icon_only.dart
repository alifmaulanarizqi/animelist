import 'package:flutter/material.dart';
import '../../utils/colors/common_colors.dart';

class OutlineButtonIcon extends StatelessWidget {
  final Function() onTap;
  final Size? minimumSize;
  final Color backgroundColor;
  final Color iconColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool isActive;
  final Color borderColor;

  const OutlineButtonIcon(
      {Key? key,
      required this.onTap,
      this.isActive = true,
      this.minimumSize,
      this.backgroundColor = Colors.white,
      this.iconColor = CommonColors.blueB5,
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
        child: Icon(
          Icons.fingerprint,
          size: 24,
          color: iconColor,
        ),
      ),
    );
  }
}
