import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user_managment/config/palette.dart';

class PopupAnimation extends StatelessWidget{
  PopupAnimation({
    this.tag,
});
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Hero(tag: tag, child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.0,vertical: 250),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: Palette.lightGrey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Lottie.asset('assets/lottie/authentication.json'),
        ),
      ),
    ));
  }
}