

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart  ';
import 'package:user_managment/config/database.dart';
import 'package:user_managment/screens/auth/widgets/decoration_functions.dart';

import 'package:user_managment/screens/auth/widgets/login_title.dart';
import 'package:user_managment/screens/auth/widgets/popup_animation.dart';
import 'package:user_managment/screens/auth/widgets/click_bar.dart';
import 'package:user_managment/screens/home/home.dart';

import 'hero_diaglog_rote.dart';

class Register extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  Database _database = Database();


  String email='';
  String password;
  String username='';
  Register({Key key,this.onSignInPressed});

  final VoidCallback onSignInPressed;

  _showBanner(String title,context){
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content: Row(
        //mainAxisAlignment: MainAxisAlignment.sp,
        children: [
          Icon(Icons.warning_amber_outlined,color: Colors.red,),
          SizedBox(
            width: 80,
          ),
          Expanded(
              child: Text(title)),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: LoginTitle(
                title: 'Create\nAccount',
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    style: TextStyle(fontSize: 18,color: Colors.white),
                    onChanged: (text) {
                      username = text;
                    },
                    textAlign: TextAlign.start,
                    decoration: registerInputDecoration(hintText: 'Username'),
                  ),
                ),
                Padding(
                  padding  : EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    style: TextStyle(fontSize: 18,color: Colors.white),
                    onChanged: (text) {
                      email = text;
                    },
                    textAlign: TextAlign.start,
                    decoration: registerInputDecoration(hintText: 'Email'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    style: TextStyle(fontSize: 18,color: Colors.white),
                    onChanged: (text) {
                      password = text;
                    },
                    obscureText: true,
                    textAlign: TextAlign.start,
                    decoration: registerInputDecoration(hintText: 'Password'),
                  ),
                ),

                Hero(
                  tag: 'sign up',
                  child: ClickBar(
                    label: 'Sign up',
                    onPress: ()async{
                     try{
                       Navigator.of(context).push(HeroDialogRoute(widgetBuilder: (context){
                         return PopupAnimation(tag: 'sign up');
                       }));

                       final newUser =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
                       if(newUser != null){
                         _database.initialize();
                         _database.create(username, email);
                         Navigator.push(context, HomeScreen.route);
                       }
                     }
                     catch(e){
                       Navigator.pop(context);
                       _showBanner("emtpy field or account  already exists", context);

                       print(e);
                     }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: (){
                      onSignInPressed?.call();
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );


  }

}
