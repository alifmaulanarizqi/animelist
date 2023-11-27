import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fms/common_ui/utils/colors/common_colors.dart';

import 'common_input_field_prefix_icon.dart';

class CommonAreaInputField extends StatefulWidget {
  final String label;
  final String hint;
  final Function(String) onChanged;
  final bool isEnable;
  final String defaultValue;
  final TextInputAction textInputAction;
  final int maxLine;
  final EnumInputFieldValidator? validator;
  final String validateErrorMessage;
  TextEditingController controller;

  CommonAreaInputField({
    Key? key,
    required this.label,
    required this.hint,
    required this.onChanged,
    required this.controller,
    this.isEnable = true,
    this.defaultValue = "",
    this.textInputAction = TextInputAction.next,
    this.maxLine = 1,
    this.validator,
    this.validateErrorMessage = "",
  }) : super(key: key);

  @override
  _CommonAreaInputFieldState createState() => _CommonAreaInputFieldState();
}

class _CommonAreaInputFieldState extends State<CommonAreaInputField> {
  static late TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller;
    _controller.text = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        _buildInputField(context),
      ],
    );
  }

  Widget _buildInputField(BuildContext context) {
    return TextFormField(
      enabled: widget.isEnable,
      controller: _controller,
      onChanged: _onChangedCallback,
      keyboardType: TextInputType.multiline,
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLine,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (widget.validator == null) {
          return null;
        }

        if (_validate(value ?? "") ?? false) {
          return null;
        }

        return widget.validateErrorMessage;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: CommonColors.blueB5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: CommonColors.blue9F,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: CommonColors.blue9F,
          ),
        ),
        hintText: widget.hint,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: CommonColors.red52,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: CommonColors.red52,
          ),
        ),
      ),
    );
  }

  void _onChangedCallback(String fieldValue) {
    widget.onChanged(fieldValue);
  }

  bool? _validate(String value) {
    switch (widget.validator) {
      case EnumInputFieldValidator.email:
        return EmailValidator.validate(value);
      default:
        return null;
    }
  }
}
