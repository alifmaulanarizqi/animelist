import 'package:flutter/material.dart';
import 'package:fms/common_ui/utils/text_style/common_text_style.dart';

import '../../utils/colors/common_colors.dart';

class CommonActionTile extends StatelessWidget {
  final Widget? icon;
  final String label;
  final Widget? secondLabel;
  final bool isCentered;
  final VoidCallback? onClick;
  final EdgeInsets padding;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Color borderColor;
  final Widget endIcon;
  final double borderRadius;
  final Color textColor;

  const CommonActionTile(
      {Key? key,
      this.icon,
      required this.label,
      this.secondLabel,
      this.onClick,
      this.isCentered = false,
      this.padding = EdgeInsets.zero,
      this.endIcon = const SizedBox.shrink(),
      this.borderColor = CommonColors.transparent,
      this.backgroundColor = Colors.white,
      this.borderRadius = 4.0,
      this.textColor = CommonColors.black10,
      this.textStyle =  CommonTypography.roboto13})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1,),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment:
                isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              buildIcon(),
              isCentered
                  ? Text(
                      label,
                      style: textStyle.copyWith(color: CommonColors.grey6D),
                    )
                  : Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle.copyWith(color: CommonColors.grey6D),
                          ),
                          Visibility(
                              visible: secondLabel != null,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    secondLabel ?? const SizedBox.shrink()
                                  ]))
                        ],
                      ),
                    ),
              endIcon
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIcon() {
    if (icon == null) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        icon ?? const SizedBox(),
        const SizedBox(width: 16),
      ],
    );
  }
}
