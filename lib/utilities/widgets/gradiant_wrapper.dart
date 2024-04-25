import 'package:flutter/material.dart';
import 'package:userapp/utilities/theming/color_theme.dart';

class primaryGradiantWidget extends StatelessWidget {
  final Widget child;

  primaryGradiantWidget({
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
          Color(0xFF935FA2),
          Color(0xFFE52E42),
            Color(0xFFF5A334),
      ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}