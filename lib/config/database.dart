import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database{
  FirebaseFirestore firestore;
  initialize(){
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try{
      querySnapshot = await firestore.collection("Users").orderBy("time_created").get();
      if(querySnapshot.docs.isNotEmpty){
        for(var doc in querySnapshot.docs.toList().reversed){

          Map temp = {"id":doc.id,"name":doc["name"],"Email":doc["Email"],"image_name":doc["image_name"]};
          docs.add(temp);
        }
        return docs;
      }
    }
    catch(e){
      print(e);
    }
  }

  Future<void> update(String id,String name) async{
    try{
      await firestore.collection("Users").doc(id).update({'name':name,});
    }
    catch(e){
      print(e);
    }
  }
  Future<void> updateImage(String id,String imageName,) async{
    try{
      await firestore.collection("Users").doc(id).update({'image_name':imageName,});
    }
    catch(e){
      print(e);
    }
  }

  Future<void >delete(String id)async{
    try{

      await firestore.collection("Users").doc(id).delete();
    }catch(e){
      print(e);
    }
  }

  Future<void> create(String name,String email)async{
    try{
      await firestore.collection("Users").add({
        'name' : name,
        'Email': email,
        'image_name' :'default.png',
        'time_created': FieldValue.serverTimestamp(),
      });
    }
    catch(e){
      print(e);
    }
  }
}