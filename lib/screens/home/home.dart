import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'widgets/background_painter.dart';

import 'package:flutter/material.dart';
import 'package:user_managment/config/database.dart';
import 'package:user_managment/config/storage.dart';
import 'package:user_managment/screens/edit.dart';
import 'package:user_managment/screens/home/widgets/shimmer_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route =>
      MaterialPageRoute(builder: (context) => HomeScreen());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  Storage _storage = Storage();
  Database _database;
  List docs = [];
  bool isLoading = false;
  AnimationController _animationController;

  initialize() async {
    setState(() {
      isLoading = true;
    });

    _database = Database();
    _database.initialize();
    await _database.read().then((value) => {
          setState(() {
            docs = value;
          })
        });

    setState(() {
      isLoading = false;
    });
    _animationController.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    initialize();
    _storage.intialize();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Signed In'),
      ),
      body: Stack(

        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: HomeBackGroundPainter(),
            ),
          ),
          ListView.builder(
            itemCount: isLoading ? 3 : docs.length,
            itemBuilder: (BuildContext context, int index) {
              return isLoading
                  ? _buildShimmerList(size)
                  : _buildLoadedList(size, index);
            },
          ),
        ],
      ),
    );
  }

  _buildLoadedList(size, index) {
    double _animationStart = index * 0.1;
    double _animationEnd = _animationStart + 0.4;
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(2.0, 0), end: Offset(0.0, 0.0))
          .animate(CurvedAnimation(
              parent: _animationController,
              curve: Interval(_animationStart, _animationEnd,
                  curve: Curves.ease))),
      child: FadeTransition(
        opacity: _animationController,
        child: Card(
          margin: EdgeInsets.all(size.width * 0.05),
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditScreen(
                      userkey: docs[index]['id'],
                      email: docs[index]['Email'],
                      username: docs[index]['name'])));
            },
            leading: _userImage(index),
            contentPadding: EdgeInsets.only(
                right: size.width * 0.1, left: size.width * 0.1),
            title: Text(docs[index]['name']),
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  _database.delete(docs[index]["id"]);
                  if (_auth.currentUser.email == docs[index]['Email']) {
                    await _auth.currentUser.delete();
                    Navigator.pop(context);
                  } else {
                    _showBanner("You can only remove your account", context);
                  }
                }),
          ),
        ),
      ),
    );
  }

  _userImage(index) => FutureBuilder(
        future: _storage.downloadFile(docs[index]['image_name']),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ClipOval(
              child: Container(
                color: Colors.grey,

                height: 50,
                width: 50,

                child: ClipOval(child: Image.network(snapshot.data,fit: BoxFit.cover,),),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return ShimmerWidget.circle(height: 50, width: 50);
          }
          return Container();
        },
      );

  _buildShimmerList(size) => Card(
        margin: EdgeInsets.all(size.width * 0.05),
        child: ListTile(
          contentPadding:
              EdgeInsets.only(right: size.width * 0.1, left: size.width * 0.1),
          leading: ShimmerWidget.circle(height: 50, width: 50),
          title: ShimmerWidget.rectangle(height: 20, width: 5),
        ),
      );

  _showBanner(String title, context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        //mainAxisAlignment: MainAxisAlignment.sp,
        children: [
          Icon(
            Icons.warning_amber_outlined,
            color: Colors.red,
          ),
          SizedBox(
            width: 100,
          ),
          Text(title),
        ],
      ),
    ));
  }
}
