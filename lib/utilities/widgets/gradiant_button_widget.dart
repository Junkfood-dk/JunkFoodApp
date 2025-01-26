import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GradiantButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const GradiantButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPressed == null ? 0.3 : 1,
      child: GradiantButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
