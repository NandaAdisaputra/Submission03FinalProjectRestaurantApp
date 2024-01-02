import 'package:flutter/material.dart';

class CustomElevatedBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final Widget child;
  final double radius;
  final BorderSide? side;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;

  const CustomElevatedBtn({
    Key? key,
    this.side,
    this.width = double.infinity,
    this.height = 48,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    required this.child,
    this.radius = 10,
    this.padding,
    this.tapTargetSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        tapTargetSize: tapTargetSize,
        padding: padding,
        side: side,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: child,
    );
  }
}