import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

import '../../utils/colors/common_colors.dart';
import '../../utils/text_style/common_text_style.dart';

enum EnumInputFieldValidator {
  email,
}

class CommonInputFieldPrefixIcon extends StatefulWidget {
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
  final Widget? prefixIcon;

  CommonInputFieldPrefixIcon({
    Key? key,
    this.label = '',
    required this.hint,
    required this.onChanged,
    this.validateErrorMessage = "",
    this.inputType = TextInputType.text,
    this.validator,
    this.isEnable = true,
    this.defaultValue = "",
    this.inputFormatters = const [],
    required this.textEditingController,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _CommonInputFieldPrefixIconState createState() =>
      _CommonInputFieldPrefixIconState();
}

class _CommonInputFieldPrefixIconState
    extends State<CommonInputFieldPrefixIcon> {
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
        widget.label.isNotEmpty
            ? Column(
                children: [
                  _buildLabel(),
                  const SizedBox(height: 8),
                ],
              )
            : const SizedBox.shrink(),
        _buildInputField(),
      ],
    );
  }

  Widget _buildLabel() {
    return Text(
      widget.label,
      style: CommonTypography.roboto14,
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
      style: CommonTypography.roboto14.copyWith(fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: CommonColors.blueE9,
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
          borderSide: BorderSide(
            color: CommonColors.greyBD,
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
