import 'package:flutter/material.dart';

import '../../utils/text_style/common_text_style.dart';

class AppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  final Color backgroundColor;
  final String textTitle;
  final Color textColor;
  final bool isUnderline;
  final IconData? icon;
  final Color iconColor;
  final List<Widget>? actions;
  final Function() onBackClicked;

  const AppBarWithBackButton({
    Key? key,
    this.textTitle = '',
    this.actions,
    this.isUnderline = false,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.icon = Icons.arrow_back,
    this.iconColor = Colors.black,
    required this.onBackClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      elevation: isUnderline ? 1 : 0,
      backgroundColor: backgroundColor,
      centerTitle: false,
      toolbarHeight: 100,
      title: Row(
        children: [
          GestureDetector(
            onTap: onBackClicked,
            child: Icon(
              icon,
              size: 28,
              color: iconColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              textTitle,
              style: CommonTypography.roboto20.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(105);
}
