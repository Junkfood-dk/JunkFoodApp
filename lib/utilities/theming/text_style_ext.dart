import 'package:flutter/material.dart';

extension TextStyleBold on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
}
