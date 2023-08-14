import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final bool isSecured;
  final TextEditingController? controller;
  final TextStyle? style;
  final String? hintText;
  final String? label;
  final bool readOnly;
  final TextInputType? inputType;
  final Widget? suffix;
  final Widget? prefix;
  final Function(String?)? onChanged;
  final Function(String?)? validator;
  final Function()? onTpped;
  final List<TextInputFormatter>? inputFormatters;
  const AppTextField({
    super.key,
    this.hintText,
    this.label,
    this.style =  const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    this.readOnly = false,
    this.isSecured = false,
    this.inputFormatters = const [],
    this.inputType = TextInputType.text,
    this.prefix,
    this.suffix,
    this.controller,
    this.validator,
    this.onChanged,
    this.onTpped,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 40,
      child: TextFormField(
          controller: widget.controller,
          readOnly: widget.readOnly,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.inputType,
          obscureText: widget.isSecured,
          style: widget.style,
          decoration: InputDecoration(
              prefixIcon: widget.prefix,
              suffixIcon: widget.suffix,
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Color(0xFF949C9E), fontSize: 16, fontWeight: FontWeight.w400),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: widget.label,
              contentPadding: const  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFE5E5E5), width: 1.0),
                  borderRadius: BorderRadius.circular(4)),
                  enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFE5E5E5), width: 1.0),
                  borderRadius: BorderRadius.circular(4)),
                  focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFE5E5E5), width: 1.0),
                  borderRadius: BorderRadius.circular(4))
                  ),
          onChanged: (value) {
            widget.onChanged!(value);
          },
          onTap: () => widget.onTpped != null ? widget.onTpped!() : null,
          validator: (value) => widget.validator!(value)),
    );
  }
}
