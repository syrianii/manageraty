import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_managment/config/database.dart';
import 'package:user_managment/config/palette.dart';
import 'package:user_managment/config/storage.dart';
import 'package:user_managment/screens/auth/widgets/click_bar.dart';
import 'package:user_managment/screens/home/widgets/shimmer_widget.dart';
import 'auth/widgets/decoration_functions.dart';

class EditScreen extends StatelessWidget {
  EditScreen(
      {Key key,
      @required this.userkey,
      @required this.email,
      @required this.username})
      : super(key: key);
  String username;
  String email;
  String userkey;
  Database _database = Database();
  Storage _storage = Storage();
  FirebaseAuth _auth = FirebaseAuth.instance;
  ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    _storage.intialize();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.darkGrey,
          title: Text("Edit User"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Center(
                        child: Stack(
                          alignment:AlignmentDirectional.topEnd,
                          children: [
                            FutureBuilder(
                              future: _storage.downloadFile(username),
                              builder:
                                  (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  return CircleAvatar(
                                    radius: 75,
                                    child: ClipOval(
                                      child: Image.network(
                                        snapshot.data,
                                        fit: BoxFit.fill,
                                        width: 175,
                                      ),
                                    ),
                                    backgroundColor: Colors.grey,
                                  );
                                }
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    !snapshot.hasData) {
                                  return ShimmerWidget.circle(
                                      height: 150, width: 150);
                                }
                                return Container();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.image_outlined,
                                color: Palette.lightGrey,
                                size: 48,
                              ),
                              onPressed: () async {
                                try {
                                  final image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  File result = File(image.path);

                                  _showBanner(
                                      "file selected successfuly", context);
                                  final path = result.path;
                                  final fileName = username;

                                  _storage.intialize();
                                  _database.initialize();
                                  _storage.uploadFile(path, fileName);
                                  _database.updateImage(userkey, username);
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: TextField(
                        onChanged: (text) {
                          username = text;
                        },
                        textAlign: TextAlign.start,
                        decoration: editInputDecoration(username),
                      ),
                    ),
                    ClickBar(
                      label: "Edit",
                      onPress: () {
                        _database.initialize();
                        _database.update(
                          userkey,
                          username,
                        );
                        _showBanner('username updated successfully!', context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: TextField(
                        onChanged: (text) {
                          email = text;
                        },
                        textAlign: TextAlign.start,
                        decoration: editInputDecoration(email),
                      ),
                    ),
                    ClickBar(
                        label: "reset password",
                        onPress: () {
                          _auth.sendPasswordResetEmail(email: email);
                          _showBanner(
                              'you have received an reset link in you email',
                              context);
                        }),
                  ],
                ),
              ),

            ],
          ),
        ));
  }

  _showBanner(String title, context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        //mainAxisAlignment: MainAxisAlignment.sp,
        children: [
          Icon(
            Icons.check_circle_outline_outlined,
            color: Colors.greenAccent,
          ),
          SizedBox(
            width: 100,
          ),
          Expanded(child: Text(title)),
        ],
      ),
    ));
  }
}
