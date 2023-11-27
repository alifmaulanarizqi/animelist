import 'package:flutter/material.dart';
import 'package:fms/common_ui/utils/text_style/common_text_style.dart';

import '../../utils/colors/common_colors.dart';
import '../button/outline_button_text.dart';
import '../button/primary_button_text_and_icon.dart';

class CommonConfirmationDialog extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String description;
  final VoidCallback? onLeftBtnClick;
  final VoidCallback? onRightBtnClick;
  final String btnTextLeft;
  final String btnTextRight;

  const CommonConfirmationDialog({
    Key? key,
    required this.title,
    this.titleColor = CommonColors.red52,
    required this.description,
    required this.onLeftBtnClick,
    required this.onRightBtnClick,
    required this.btnTextLeft,
    required this.btnTextRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CommonColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      alignment: Alignment.center,
      child: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Text(
                title,
                style: CommonTypography.roboto20.copyWith(
                  fontSize: 24,
                  color: CommonColors.blueE9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 24, right: 24),
              child: description.isNotEmpty
                  ? Text(
                description,
                textAlign: TextAlign.center,
                style: CommonTypography.roboto14.copyWith(
                  color: CommonColors.greyB4,
                  fontWeight: FontWeight.w500,
                ),
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
                child:  Row(
                  children: [
                    Expanded(
                      child: PrimaryButtonTextAndIcon(
                        borderRadius: 8,
                        textColor: CommonColors.blueB5,
                        horizontalPadding: 5,
                        verticalPadding: 5,
                        onTap: () {
                          Navigator.pop(context);
                          onLeftBtnClick?.call();
                        },
                        fontSize: 18,
                        label: btnTextLeft,
                        backgroundColor: CommonColors.white,
                        borderColor: CommonColors.blueB5,
                        isActive: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: PrimaryButtonTextAndIcon(
                        borderRadius: 8,
                        textColor: Colors.white,
                        horizontalPadding: 5,
                        verticalPadding: 5,
                        onTap: () {
                          Navigator.pop(context);
                          onRightBtnClick?.call();
                        },
                        fontSize: 18,
                        label: btnTextRight,
                        backgroundColor: CommonColors.blueE9,
                        isActive: true,
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
