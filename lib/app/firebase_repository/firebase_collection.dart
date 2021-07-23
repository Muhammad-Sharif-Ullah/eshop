import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/firebase_repository/firebase_auth.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseCollection {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final String users = 'users';
  static final String beg = 'users';

  static saveUserData(String name, String? url, User user) async {
    await _instance.collection(users).doc(user.uid).set({
      'name': name,
      'email': user.email,
      'uid': user.uid,
      'avatar': url,
    });
  }

  static addToBeg(
      {required Map<String, dynamic> begMap, required String prodId}) async {

    String uid = FirebaseAuth.instance.currentUser!.uid;
   await _instance.doc("$beg/$uid/beg/$prodId").get().then((doc) async {
     if(!doc.exists)
       await _instance
         .collection("$beg/$uid/beg")
         .doc(prodId)
         .set(begMap)
         .then((value) => print('success'))
         .onError((FirebaseException error, stackTrace) => print(error.code)).catchError((error){
       print(error);
     });
   });


  }

  FireBaseCollection._();
}
