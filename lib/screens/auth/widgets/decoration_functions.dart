import 'package:flutter/material.dart';
import 'package:user_managment/config/palette.dart';

InputDecoration registerInputDecoration({String hintText}){
  return InputDecoration(

    contentPadding: const EdgeInsets.symmetric(vertical: 18),
    hintStyle: TextStyle(color: Colors.grey,fontSize: 18),
    hintText: hintText,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color:Colors.white),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Palette.red),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 2.0,color: Palette.red),
    ),
    errorStyle: TextStyle(color: Colors.white),
  );

}
InputDecoration editInputDecoration(String labelText){
  return InputDecoration(
    focusColor: Colors.white,
    labelStyle: TextStyle(color: Palette.darkGrey),
   hintText: labelText,
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(width: 2, color: Palette.darkGrey),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Palette.darkGrey),
    ),

  );
}

InputDecoration signInInputDecoration({String hintText}) {
  return InputDecoration(
    helperText: '*required',

    contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
    hintStyle: const TextStyle(fontSize: 18),
    hintText: hintText,
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(width: 2, color: Palette.darkGrey),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Palette.darkGrey),
    ),
    errorBorder:  UnderlineInputBorder(
      borderSide: BorderSide(color: Palette.lightRose),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: Palette.lightRose),
    ),
    errorStyle: const TextStyle(color: Palette.lightRose),
  );


}

