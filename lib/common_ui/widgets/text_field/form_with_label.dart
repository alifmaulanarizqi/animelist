import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:email_validator/email_validator.dart';

import '../../utils/colors/common_colors.dart';
import '../../utils/text_style/common_text_style.dart';

enum InputFieldValidator { email, isEmpty, phoneNumber }

class FormWithLabel extends StatefulWidget {
  final String label;
  final bool isEnable;
  TextEditingController controller;
  final String initialValue;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final List<InputFieldValidator> validators;
  final AutovalidateMode? autovalidateMode;
  final String validateErrorMessage;
  final List<TextInputFormatter> inputFormatters;
  final Function(String) onChanged;
  final String textHint;
  final TextAlign textAlign;
  final double horizontalPadding;
  final double verticalPadding;

  FormWithLabel({
    super.key,
    this.label = "",
    this.isEnable = true,
    this.keyboardType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.validators = const [],
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validateErrorMessage = "",
    this.inputFormatters = const [],
    required this.onChanged,
    required this.controller,
    this.initialValue = "",
    this.textHint = "",
    this.textAlign = TextAlign.start,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 20.0,
  });

  @override
  State<FormWithLabel> createState() => _FormWithLabelState();
}

class _FormWithLabelState extends State<FormWithLabel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label.isNotEmpty ? _buildLabel() : const SizedBox.shrink(),
        _buildFormWithLabel(),
      ],
    );
  }

  Widget _buildLabel() {
    return Column(
      children: [
        Text(
          widget.label,
          style: CommonTypography.heading8,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildFormWithLabel() {
    return TextFormField(
      enabled: widget.isEnable,
      controller: widget.initialValue.isNotEmpty ? null : widget.controller,
      onChanged: _onChangedCallback,
      textInputAction: widget.inputAction,
      keyboardType: widget.keyboardType,
      autovalidateMode: widget.autovalidateMode,
      initialValue: widget.initialValue.isEmpty ? null : widget.initialValue,
      validator: _validate,
      inputFormatters: widget.inputFormatters,
      style: CommonTypography.body,
      textAlign: widget.textAlign,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: widget.verticalPadding,
            horizontal: widget.horizontalPadding),
        hintText: widget.textHint.isEmpty ? widget.label : widget.textHint,
        // default state
        filled: true,
        isDense: true,
        fillColor: widget.isEnable ? CommonColors.white : Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CommonColors.greyD7,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CommonColors.greyD7,
          ),
        ),
        focusColor: CommonColors.black50,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CommonColors.blue9F,
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
        // end of error state
      ),
    );
  }

  void _onChangedCallback(String value) {
    widget.onChanged(value);
  }

  String? _validate(String? value) {
    var isRequired = widget.validators.contains(
      InputFieldValidator.isEmpty,
    );

    var isValidEmail = widget.validators.contains(
      InputFieldValidator.email,
    );

    var phoneNumber = widget.validators.contains(
      InputFieldValidator.phoneNumber,
    );

    if (isRequired && (value == null || value.isEmpty)) {
      return "${widget.label} cannot be empty";
    }

    if (isValidEmail && !(EmailValidator.validate(value ?? ""))) {
      return "Please use a valid email address.";
    }

    if (phoneNumber &&
        ((value?.length ?? 0) > 13 || (value?.length ?? 0) < 10)) {
      return "${widget.label} length must be at least 10 and less than 13";
    }

    return null;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
