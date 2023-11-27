import 'package:flutter/material.dart';

class CommonLoadingDialog extends StatelessWidget {
  const CommonLoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
