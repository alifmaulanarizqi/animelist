import 'package:flutter/material.dart';

import '../../utils/colors/common_colors.dart';
import '../../utils/icons/common_icons.dart';
import '../../utils/text_style/common_text_style.dart';

class FormMessage extends StatelessWidget {
  final bool isCorrect;
  final String message;
  const FormMessage({
    required this.isCorrect,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: isCorrect == true ? CommonColors.green50 : CommonColors.red52,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          isCorrect == true
              ? const Icon(Icons.check_circle,
                  color: CommonColors.green50, size: 16)
              : CommonIcons.closeCirlce,
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: CommonTypography.caption.copyWith(
                  color: isCorrect == true
                      ? CommonColors.green50
                      : CommonColors.red52),
            ),
          ),
        ],
      ),
    );
  }
}
