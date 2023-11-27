import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fms/common_ui/utils/text_style/common_text_style.dart';

import '../../../core/utils/colors_util.dart';
import '../common_loading.dart';

class CommonImageWidget extends StatelessWidget {
  final String imageUrl;
  final double size;
  final String userName;
  final bool isCounter;

  const CommonImageWidget(
      {Key? key,
      required this.imageUrl,
      this.size = 48,
      this.userName = '',
      this.isCounter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty && userName.isNotEmpty) {
      return generateUsernamePicture();
    } else if (imageUrl.isEmpty) {
      return Image.asset(
        'assets/images/img_no_image.png',
        fit: BoxFit.cover,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (_, __) => CommonLoading(
        height: size,
        width: size,
      ),
      errorWidget: (_, __, ___) {
        return _buildErrorWidget();
      },
      imageBuilder: (_, provider) {
        return Image(
          image: provider,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildErrorWidget() {
    if (userName.isNotEmpty) {
      return generateUsernamePicture();
    } else {
      return Image.asset(
        'assets/images/img_no_image.png',
        fit: BoxFit.cover,
      );
    }
  }

  Widget generateUsernamePicture() {
    List<String> nameParts = userName.split(' ');
    String initials = '';
    if (isCounter) {
      initials = userName;
    } else {
      for (int i = 0; i < nameParts.length && i < 2; i++) {
        initials += nameParts[i].substring(0, 1).toUpperCase();
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: ColorsUtil.getRandomColorFromString(userName),
        shape: BoxShape.circle,
      ),
      child: Text(
        initials,
        style: isCounter
            ? CommonTypography.heading9.copyWith(color: Colors.white)
            : CommonTypography.roboto16.copyWith(fontSize: 11, color: Colors.white),
      ),
    );
  }
}
