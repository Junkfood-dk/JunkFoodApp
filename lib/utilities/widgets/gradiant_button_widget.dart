import 'package:flutter/material.dart';

class GradiantButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double? width;

  const GradiantButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPressed == null ? 0.3 : 1,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(
          minHeight: 48.0,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF935FA2),
              Color(0xFFE52E42),
              Color(0xFFF5A334),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
