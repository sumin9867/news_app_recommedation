import 'package:flutter/material.dart';

class UnFocus extends StatelessWidget {
  const UnFocus({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
