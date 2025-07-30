import 'package:flutter/material.dart';

abstract class AppButtonStyle {
  static const ButtonStyle linkButton = ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Color(0xFF01B4E4)),
    textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
    );
}