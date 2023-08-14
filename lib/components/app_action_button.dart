import 'package:employees_app/utils/constants.dart';
import 'package:flutter/material.dart';

class AppActionButton extends StatelessWidget {
  const AppActionButton(
      {super.key,
      required this.title,
      this.backgroundColor = kPrimaryColor,
      this.fontSize = 14,
      this.width = double.infinity,
      this.height = 40,
      this.textColor = Colors.white,
      this.isSelected = true,
      required this.onPressed});
  
  /// Title of the button
  final String title;

  /// onPressed callback called when click the button
  final Function()? onPressed;

  /// background color for the button
  final Color? backgroundColor;

  /// Text color for the title of the button
  final Color? textColor;

  /// Font size of the button title
  final double? fontSize;

  /// height of the button
  final double? height;

  /// Width of the button
  final double? width;

  /// background color and text color will be based on `isSelected` status
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                (isSelected ?? false) ? backgroundColor : kSecondaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
          child: Text(
            title,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: (isSelected ?? false) ? textColor : kPrimaryColor),
          )),
    );
  }
}
