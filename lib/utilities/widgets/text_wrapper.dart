import 'package:flutter/material.dart';

class DisplayLargeText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const DisplayLargeText({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.displayLarge,
    );
  }
}

class DisplayMediumText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const DisplayMediumText({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.displayMedium,
    );
  }
}

class TitleLargeText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const TitleLargeText({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.titleLarge,
    );
  }
}

class ButtonText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const ButtonText({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.labelMedium,
    );
  }
}

class BodyText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const BodyText({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class BodyBoldText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const BodyBoldText({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodyLarge,
    );
  }
}

