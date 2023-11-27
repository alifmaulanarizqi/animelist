import 'package:flutter/material.dart';
import 'package:fms/common_ui/utils/text_style/common_text_style.dart';

import '../../utils/colors/common_colors.dart';
import '../button/primary_button_text_and_icon.dart';

class CommonSuccessDialog extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String description;
  final VoidCallback? onBtnClick;
  final String btnText;

  const CommonSuccessDialog({
    Key? key,
    required this.title,
    this.titleColor = CommonColors.blueE9,
    required this.description,
    required this.onBtnClick,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.all(24),
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding:
                const EdgeInsets.only(top: 24, right: 24, left: 0, bottom: 4),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close_outlined,
                  size: 18,
                  color: CommonColors.greyD7,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              title,
              style: CommonTypography.heading7.copyWith(
                  fontWeight: FontWeight.w600, color: titleColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18, left: 24, right: 24),
            child: description.isNotEmpty
                ? Text(
                    description,
                    textAlign: TextAlign.center,
                    style: CommonTypography.heading8.copyWith(
                        fontWeight: FontWeight.w500,
                        color: CommonColors.greyB4),
                  )
                : Container(),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: description.isNotEmpty ? 28 : 18,
              left: 24,
              right: 24,
              bottom: 18,
            ),
            child: PrimaryButtonTextAndIcon(
                onTap: () {
                  Navigator.pop(context);
                  onBtnClick?.call();
                },
                customWidth: 100,
                fontSize: 14,
                label: btnText,
                isActive: true),
          ),
        ],
      ),
    );
  }
}
