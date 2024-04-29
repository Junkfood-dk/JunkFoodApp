import 'package:flutter/material.dart';

class DisplayLargeText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextScaler? scaler;
  final TextOverflow? overflow;

  const DisplayLargeText(
      {Key? key,
      required this.text,
      this.style,
      this.maxLines,
      this.scaler,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.displayLarge,
      maxLines: maxLines,
      textScaler: scaler,
      overflow: overflow,
    );
  }
}

class DisplayMediumText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;

  const DisplayMediumText(
      {Key? key, required this.text, this.style, this.maxLines, this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.displayMedium,
      maxLines: maxLines,
      overflow: overflow,
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
  final int? maxLines;
  final TextOverflow? overflow;

  const BodyText({
    Key? key,
    required this.text,
    this.style,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

class BodyBoldText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  const BodyBoldText(
      {Key? key, required this.text, this.style, this.maxLines, this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodyLarge,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
