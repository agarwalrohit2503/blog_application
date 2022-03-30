import 'package:flutter/material.dart';

class ConstrainedCenter extends StatelessWidget {
  final Widget child;
  const ConstrainedCenter({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: child,
      ),
    );
  }
}
