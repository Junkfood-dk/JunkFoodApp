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
          colorTheme.primary,
          colorTheme.secondary,
            colorTheme.tertiary,
      ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}