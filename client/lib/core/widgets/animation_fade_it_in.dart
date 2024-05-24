import 'package:flutter/material.dart';

class AnimationFindIn extends StatelessWidget {
  dynamic child;

  AnimationFindIn({Key? key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      child: child,
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 1000),
      builder: (BuildContext context, double val, Widget? child) {
        return Opacity(
          opacity: val,
          child: child,
        );
      },
    );
  }
}
