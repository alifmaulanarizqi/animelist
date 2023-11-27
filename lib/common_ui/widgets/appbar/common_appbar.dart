import 'package:flutter/material.dart';

import '../../utils/text_style/common_text_style.dart';

class CommonAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final Color backgroundColor;
  final String textTitle;
  final Color textColor;

  const CommonAppbar({
    Key? key,
    this.textTitle = '',
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: backgroundColor,
      centerTitle: false,
      toolbarHeight: 100,
      title: Row(
        children: [
          Text(
            textTitle,
            style: CommonTypography.roboto20.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
