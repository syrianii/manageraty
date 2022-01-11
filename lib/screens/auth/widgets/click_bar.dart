import 'package:flutter/material.dart';

import 'package:user_managment/config/palette.dart';

class ClickBar extends StatelessWidget {
  const ClickBar({Key key,@required this.label,@required  this.onPress,})
      : super(key: key);

  final String label;
  final Function onPress;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: GestureDetector(
          onTap: onPress,
          child: Center(
            child: Text(label,style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: Palette.darkGrey,
            ),),
          ),
        )
      ),
    );
  }
}


