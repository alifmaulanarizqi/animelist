import 'package:flutter/material.dart';

class CommonLoading extends StatelessWidget {
  final double height;
  final double width;

  const CommonLoading({
    Key? key,
    this.height = 200,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}