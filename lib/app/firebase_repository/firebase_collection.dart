import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/firebase_repository/firebase_auth.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseCollection {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final String users = 'users';
  static final String beg = 'beg';
  static final String favorites = 'favorites';
  static final String products = 'products';
  static final String address = 'address';
  static final String reviews = 'reviews';
  static final String orders = 'orders';

  static saveUserData(String name, String? url, User user) async {
    await _instance.collection(users).doc(user.uid).set({
      'name': name,
      'email': user.email,
      'uid': user.uid,
      'avatar': url,
    });
  }

  static addToBeg({required Map<String, dynamic> begMap}) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    ///Checking if the beg items is already exists
    ///in the firebase collection then no need to create new one.
    await _instance
        .doc("$beg/$uid/beg/${begMap['id']}")
        .get()
        .then((doc) async {
      if (!doc.exists)

        /// if not exist add the beg in the firebase beg collection
        await _instance
            .collection("$users/$uid/$beg")
            .doc(begMap['id'])
            .set(begMap)
            .then((value) {})
            .onError((FirebaseException error, stackTrace) {
          print(error.code);
        }).catchError((error) {
          print(error);
        });
    });
  }

  static addToMyFavorites(String prodId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await _instance
        .doc("$users/$uid/")
        .collection('$favorites')
        .doc("favorites_list")
        .get()
        .then((doc) async {
      if (doc.exists == true) {
        List<String> previousList = [...doc.get('product_id')];

        if (!previousList.contains(prodId)) {
          previousList.add(prodId);
          _instance
              .doc("$users/$uid/$favorites/favorites_list")
              .update({"product_id": previousList});
        }
      } else {
        print(doc.exists);
        await _instance
            .collection("$users/$uid/$favorites")
            .doc('favorites_list')
            .set({
          "product_id": [prodId],
        });
      }
    });
  }

  static Future<dynamic> getProductData(String prodID, String filed) async {
    final data = await _instance
        .collection(products)
        .doc(prodID)
        .get()
        .then((value) => (value[filed]));
    return data;
  }

  static creatingUserCollection(String uid) async {
    // Creating a beg collection
    String begUrl = "$users/$uid/$beg";
    await _instance.collection(begUrl).add({'test': 't'}).then((value) {
      // _instance.doc('$begUrl/${value.id}').delete();
    });

    // Creating a  favorite collection
    String favoritesUrl = "$users/$uid/$favorites";
    await _instance
        .collection(favoritesUrl)
        .add({'test': 'test'}).then((value) {
      // _instance.doc('$favoritesUrl/${value.id}').delete();
    });
    // Creating a Order collection
    String orderUrl = "$users/$uid/$orders";
    await _instance.collection(orderUrl).add({'test': 'test'}).then((value) {
      // _instance.doc('$orderUrl/${value.id}').delete();
    });

    // Creating a Address collection
    String addressUrl = "$users/$uid/$address";
    await _instance.collection(addressUrl).add({'test': 'test'}).then((value) {
      // _instance.doc('$addressUrl/${value.id}').delete();
    });

    // Creating a Reviews collection
    String reviewsUrl = "$users/$uid/$reviews/test";
    String rID = '';
    await _instance.collection(reviewsUrl).add({'test': 'test'}).then((value) {
      // _instance.doc('$reviewsUrl/${value.id}').delete();
      // rID = value.id;
    });
    // _instance.doc('$reviewsUrl/$rID').delete();
  }

  FireBaseCollection._();
}
