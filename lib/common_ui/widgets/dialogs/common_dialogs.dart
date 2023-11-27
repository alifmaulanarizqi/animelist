import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../../../core/domain/models/key_value_dto.dart';
import '../../utils/colors/common_colors.dart';
import 'common_confirmation_dialog.dart';
import 'common_loading_dialog.dart';
import 'common_success_dialog.dart';

class CommonDialogs {
  static Future showSuccessDialog(
    BuildContext context, {
    String title = 'Success',
    String description = '',
    VoidCallback? onBtnClick,
    String btnText = 'Close',
  }) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return CommonSuccessDialog(
          title: title,
          description: description,
          onBtnClick: onBtnClick,
          btnText: btnText,
        );
      },
    );
  }

  static void showToastMessage(
    String? message,
  ) {
    Fluttertoast.showToast(
      msg: message ?? '',
      backgroundColor: Colors.black.withOpacity(0.3),
    );
  }

  static Future showConfirmationDialog(
    BuildContext context, {
    String title = 'Title',
    Color titleColor = CommonColors.red52,
    String description = '',
    VoidCallback? onLeftBtnClick,
    VoidCallback? onRightBtnClick,
    String btnTextLeft = 'Cancel',
    String btnTextRight = 'Continue',
  }) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return CommonConfirmationDialog(
          title: title,
          titleColor: titleColor,
          description: description,
          onLeftBtnClick: onLeftBtnClick,
          onRightBtnClick: onRightBtnClick,
          btnTextLeft: btnTextLeft,
          btnTextRight: btnTextRight,
        );
      },
    );
  }

  static Future showLoadingDialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return const CommonLoadingDialog();
      },
    );
  }

  static Future showCustomBottomSheet(BuildContext context, Widget widget) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return WillPopScope(
          // Prevent back button from dismissing the bottom sheet
          onWillPop: () async => false,
          child: GestureDetector(
            onTap: () {
              // Do nothing on tap to prevent closing the bottom sheet
            },
            child: widget,
          ),
        );
      },
    );
  }
}
