import 'dart:async';

import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart  ';
import 'package:simple_animations/simple_animations.dart';
import 'package:user_managment/screens/auth/widgets/decoration_functions.dart';
import 'package:user_managment/screens/auth/widgets/hero_diaglog_rote.dart';

import 'package:user_managment/screens/auth/widgets/login_title.dart';
import 'package:user_managment/screens/auth/widgets/particles.dart';
import 'package:user_managment/screens/auth/widgets/popup_animation.dart';
import 'package:user_managment/screens/auth/widgets/click_bar.dart';
import 'package:user_managment/screens/home/home.dart';

class SignIn extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String email;
  bool showAnimation = false;
  String password;
  SignIn({Key key, @required this.onRegisterClicked});

  final VoidCallback onRegisterClicked;
  final List<Particle> particles = [];

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
                title: 'Welcome\nback',
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    onChanged: (text) {
                      email = text;
                    },
                    textAlign: TextAlign.start,
                    decoration: signInInputDecoration(hintText: 'Email'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    onChanged: (text) {
                      password = text;
                    },
                    obscureText: true,
                    textAlign: TextAlign.start,
                    decoration: signInInputDecoration(hintText: 'Password'),
                  ),
                ),
                Rendering(
                  onTick: (time) => _manageParticleLife(time),
                  builder: (context, time) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        ...particles.map((e) => e.buildWidget(time)),
                        Hero(
                          tag: 'sign in',
                          child: ClickBar(

                            label: 'Sign in',
                            onPress: () async {
                              try {
                                Iterable.generate(5).forEach((element) {
                                  particles.add(Particle(time));
                                });
                                Navigator.of(context).push(HeroDialogRoute(widgetBuilder: (context){
                                  return PopupAnimation(tag: 'sign in');
                                }));


                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);


                                if (user != null) {
                                  Timer(Duration(seconds: 2), () {
                                    Navigator.of(context).pushReplacement(_createRoute());
                                  });
                                }
                              } catch (e) {
                                Navigator.pop(context);

                                _showBanner("User Not Found",context, Icon(Icons.warning_amber_outlined,color: Colors.red,),);
                                print(e);
                              }

                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        onRegisterClicked?.call();
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),

                    InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        try{
                          print(email);
                          if(email.isNotEmpty){
                            _auth.sendPasswordResetEmail(email: email);
                            _showBanner("a reset link was sent to your email", context, Icon(Icons.check_circle_outline_outlined,color: Colors.greenAccent,));
                          }
                        }
                        catch(e){
                          print(e);
                          _showBanner("Enter an existing email", context, Icon(Icons.warning_amber_outlined,color: Colors.red,));
                        }
                      },
                      child: Text(
                        'Forgot password ?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondAnimation) => HomeScreen(),
        transitionsBuilder: (context, animation, secondAnimation, child) {
          const begin = Offset(2, 0);
          const end = Offset.zero;
          final curve = Curves.easeOutSine;
          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        });
  }

  _manageParticleLife(time) {
    particles.removeWhere((particle) {
      return particle.progress.progress(time) == 1;
    });
  }
  _showBanner(String title,context,Icon icon){
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content: Row(
        //mainAxisAlignment: MainAxisAlignment.sp,
        children: [
         icon,
          SizedBox(
            width: 100,
          ),
          Text(title),
        ],
      ),
    ));
  }



}
