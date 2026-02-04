import 'package:flutter/material.dart';

class AppPadding extends EdgeInsetsDirectional {
  @override
  final double vertical, horizontal;

  const AppPadding.set({
    double start = 0,
    double top = 0,
    double end = 0,
    double bottom = 0,
    double all = 0,
    this.vertical = 0,
    this.horizontal = 0,
  }) : super.only(
         bottom: bottom + vertical + all,
         top: top + vertical + all,
         end: end + horizontal + all,
         start: start + horizontal + all,
       );
}
