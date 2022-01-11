import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_managment/config/palette.dart';
import 'package:user_managment/screens/auth/auth_screen.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());



}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.muliTextTheme(),
        accentColor: Palette.red,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: Palette.darkGrey,
        )
      ),

      home:AuthScreen(),
    );}
}
