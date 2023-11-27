import 'package:flutter/material.dart';

import '../../utils/colors/common_colors.dart';
import '../../utils/text_style/common_text_style.dart';

class CommonErrorState extends StatelessWidget {
  final String imageUrl;
  final double imageSize;
  final String text;
  final String secondText;

  const CommonErrorState({
    Key? key,
    this.imageUrl = "",
    this.imageSize = 300,
    this.text = "Error",
    this.secondText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl.isEmpty
                ? 'assets/images/img_feature_not_ready.png'
                : imageUrl,
            width: double.infinity,
            height: imageSize,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(
            text,
            style: CommonTypography.heading6.copyWith(
              fontWeight: FontWeight.w400,
              color: CommonColors.black50.withOpacity(0.7),
            ),
          ),
          if (secondText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondText,
                style: CommonTypography.roboto16.copyWith(
                  fontWeight: FontWeight.w500,
                  color: CommonColors.greyD7,
                ),
              ),
            )
        ],
      ),
    );
  }
}
