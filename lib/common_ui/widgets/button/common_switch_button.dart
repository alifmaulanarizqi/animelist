import 'package:flutter/material.dart';

import '../../utils/colors/common_colors.dart';

class CommonSwitchButton extends StatefulWidget {
  bool value;
  final void Function() updateValue;

  CommonSwitchButton(
      {super.key, required this.value, required this.updateValue});

  @override
  State<CommonSwitchButton> createState() => _CommonSwitchButtonState();
}

class _CommonSwitchButtonState extends State<CommonSwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: widget.value ? CommonColors.blueB5 : CommonColors.white,
        border: Border.all(
          width: 2,
          color: CommonColors.blueB5,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      width: 47,
      height: 29,
      child: Switch(
        value: widget.value,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        trackColor: MaterialStateProperty.all<Color?>(
            widget.value ? CommonColors.blueB5 : CommonColors.white),
        thumbColor: MaterialStateProperty.all<Color?>(
            widget.value ? CommonColors.white : CommonColors.blueB5),
        onChanged: (bool value) {
          widget.updateValue();
          setState(() {
            widget.value = value;
          });
        },
      ),
    );
  }
}
