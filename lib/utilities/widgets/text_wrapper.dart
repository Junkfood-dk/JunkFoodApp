import 'package:flutter/material.dart';

class DisplayLargeText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextScaler? scaler;
  final TextOverflow? overflow;

  const DisplayLargeText(
      {Key? key,
      required this.text,
      this.style,
      this.textAlign,
      this.maxLines,
      this.scaler,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.displayLarge,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      textScaler: scaler,
      overflow: overflow,
    );
  }
}

class DisplayMediumText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const DisplayMediumText({
    Key? key,
    required this.text,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.displayMedium,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class TitleLargeText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const TitleLargeText({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.titleLarge,
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}

class ButtonText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const ButtonText({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.labelMedium,
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}

class BodyText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const BodyText({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
      textAlign: textAlign ?? TextAlign.left,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

class BodyBoldText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const BodyBoldText({
    Key? key,
    required this.text,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodyLarge,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
