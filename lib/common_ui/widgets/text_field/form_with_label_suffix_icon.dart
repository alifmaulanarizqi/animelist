import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/colors/common_colors.dart';
import '../../utils/text_style/common_text_style.dart';

enum EnumInputFieldValidator {
  email,
  isEmpty,
}

class FormWithLabelSuffixIcon extends StatelessWidget {
  final String label;
  final bool isEnable;
  TextEditingController controller;
  final String defaultValue;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<EnumInputFieldValidator> validators;
  final String validateErrorMessage;
  final List<TextInputFormatter> inputFormatters;
  final Function(String) onChanged;
  final bool isShowObscuredText;
  final Function(bool)? onSuffixClick;
  final String hintText;

  FormWithLabelSuffixIcon({
    super.key,
    required this.label,
    this.isEnable = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.validators = const [],
    this.validateErrorMessage = "",
    this.inputFormatters = const [],
    required this.onChanged,
    required this.controller,
    this.defaultValue = "",
    this.isShowObscuredText = false,
    this.onSuffixClick,
    this.hintText = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(),
        const SizedBox(height: 8),
        _buildFormWithLabelSuffixIcon(),
      ],
    );
  }

  Widget _buildLabel() {
    return Text(
      label,
      style: CommonTypography.heading8,
    );
  }

  Widget _buildSuffixIconVisibility() {
    return IconButton(
      icon: isShowObscuredText
          ? const Icon(
              Icons.visibility_off_outlined,
              color: CommonColors.greyD7,
            )
          : const Icon(
              Icons.visibility_outlined,
              color: CommonColors.greyD7,
            ),
      onPressed: _onSuffixIconClick,
    );
  }

  Widget _buildFormWithLabelSuffixIcon() {
    return TextFormField(
      enabled: isEnable,
      obscureText: !isShowObscuredText,
      controller: controller,
      onChanged: _onChangedCallback,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: _validate,
      inputFormatters: inputFormatters,
      style: CommonTypography.body,
      decoration: InputDecoration(
        suffixIcon: _buildSuffixIconVisibility(),
        // default state
        filled: true,
        fillColor: CommonColors.white,
        hintText: hintText.isEmpty ? label : hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CommonColors.greyD7,
          ),
        ),
        // end of default state
        // focus state
        focusColor: CommonColors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CommonColors.greyD7,
          ),
        ),
        // end of focus state
        // error state
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
        // end of error state
      ),
    );
  }

  void _onSuffixIconClick() {
    if (isShowObscuredText) {
      onSuffixClick?.call(false);
    } else {
      onSuffixClick?.call(true);
    }
  }

  void _onChangedCallback(String value) {
    onChanged(value);
  }

  String? _validate(String? value) {
    var isRequired = validators.contains(
      EnumInputFieldValidator.isEmpty,
    );

    if (isRequired && (value == null || value.isEmpty)) {
      return "$label cannot be empty";
    }

    return null;
  }
}
