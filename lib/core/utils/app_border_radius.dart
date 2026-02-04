import 'package:flutter/material.dart';

class AppBorderRadius extends BorderRadiusDirectional {
  AppBorderRadius.set({
    double topStart = 0.0,
    double topEnd = 0.0,
    double bottomEnd = 0.0,
    double bottomStart = 0.0,
    double start = 0.0,
    double end = 0.0,
    double top = 0.0,
    double bottom = 0.0,
    double all = 0.0,
  }) : super.only(
         topStart: Radius.circular(topStart + start + all + top),
         topEnd: Radius.circular(topEnd + end + all + top),
         bottomStart: Radius.circular(bottomStart + start + all + bottom),
         bottomEnd: Radius.circular(bottomEnd + end + all + bottom),
       );
}
