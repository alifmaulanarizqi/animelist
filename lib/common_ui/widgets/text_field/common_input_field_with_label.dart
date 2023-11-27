import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

import '../../utils/colors/common_colors.dart';
import '../../utils/text_style/common_text_style.dart';

enum EnumInputFieldValidator {
  email,
}

class CommonInputFieldWithLabel extends StatefulWidget {
  final String label;
  final String hint;
  final Function(String) onChanged;
  final bool isEnable;
  final String defaultValue;
  final TextInputType inputType;
  final List<TextInputFormatter> inputFormatters;
  TextEditingController textEditingController;
  final EnumInputFieldValidator? validator;
  final String validateErrorMessage;

  CommonInputFieldWithLabel({
    Key? key,
    required this.label,
    required this.hint,
    required this.onChanged,
    this.validateErrorMessage = "",
    this.inputType = TextInputType.text,
    this.validator,
    this.isEnable = true,
    this.defaultValue = "",
    this.inputFormatters = const [],
    required this.textEditingController,
  }) : super(key: key);

  @override
  _CommonInputFieldWithLabelState createState() =>
      _CommonInputFieldWithLabelState();
}

class _CommonInputFieldWithLabelState extends State<CommonInputFieldWithLabel> {
  @override
  void initState() {
    widget.textEditingController.text = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(),
        const SizedBox(height: 8),
        _buildInputField(),
      ],
    );
  }

  Widget _buildLabel() {
    return Text(
      widget.label,
      style: CommonTypography.body,
    );
  }

  Widget _buildInputField() {
    return TextFormField(
      enabled: widget.isEnable,
      controller: widget.textEditingController,
      onChanged: _onChangedCallback,
      textInputAction: TextInputAction.next,
      keyboardType: widget.inputType,
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
      inputFormatters: widget.inputFormatters,
      style: CommonTypography.body,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CommonColors.greyD7,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CommonColors.red52,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CommonColors.red52,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CommonColors.blue9F,
          ),
        ),
      ),
    );
  }

  void _onChangedCallback(String value) {
    widget.onChanged(value);
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
