import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final double? width;
  final Color? color;
  const CustomAppButton({
    super.key,
    this.title,
    this.onTap,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
        ),
        child: Text(title ?? "", textAlign: TextAlign.center),
      ),
    );
  }
}
