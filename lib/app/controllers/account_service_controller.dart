import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/firebase_repository/firebase_storage.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/model/delivery_model.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/model/shipping_model.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AccountServiceController extends GetxController {
  final FirebaseAuth instance = FirebaseAuth.instance;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final RxList<BegModel> beg = RxList<BegModel>([]);
  final RxList<String> favoritesId = RxList<String>([]);
  final RxDouble total = 0.0.obs;
  final RxDouble testTotal = 0.0.obs;
  final RxBool sale = false.obs;
  final RxBool newArrivals = true.obs;
  final RxBool deliveryStatus = false.obs;
  final RxList<ShippingModel> shippingAddress = RxList<ShippingModel>([]);

  final RxBool isRequesting = false.obs;
/////////////////
//   static const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       'This channel is used for important notifications.', // description
//       importance: Importance.high,
//       enableVibration: true,
//       showBadge: true,
//
//       playSound: true);
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print('A bg message just showed up :  ${message.messageId}');
//   }
////////////////
  @override
  onInit() async {
    ///////////
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    //
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);
    //
    // await FirebaseMessaging.instance
    //     .setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
    ///////////

    ///////////
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channel.description,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ));
    //   }
    // });
    ///////////

    ///////////
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     Get.snackbar(notification.title!, notification.body!);
    //   }
    // });
    ///////////

    super.onInit();
  }

  // void showNotification() {
  //   flutterLocalNotificationsPlugin.show(
  //     0,
  //     "Testing Notification",
  //     "How you doin ?",
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //           channel.id, channel.name, channel.description,
  //           importance: Importance.high,
  //           color: Colors.blue,
  //           playSound: true,
  //           icon: '@mipmap/ic_launcher'),
  //     ),
  //   );
  // }

  @override
  void onReady() async {
    beg.bindStream(getBegAsStream());
    favoritesId.bindStream(favoritesIdAsStream());
    shippingAddress.bindStream(shippingAddresssStream());
    testTotal.listen((d) {
      for (var i in beg) testTotal.value += double.parse(i.price!);
    });
    super.onReady();
  }

  @override
  void onClose() {}

  Future<String> getDownloadLink(String url) =>
      FireBaseStorage.getDownloadLink(url);

  Stream<List<BegModel>> getBegAsStream() {
    return fireStore
        .collection('users/${instance.currentUser!.uid}/beg')
        .snapshots()
        .map((begs) {
      return begs.docs.map((beg) => BegModel.fromJson(beg.data())).toList();
    });
  }

  Stream<List<String>> favoritesIdAsStream() {
    return fireStore
        .doc('users/${instance.currentUser!.uid}/favorites/favorites_list')
        .snapshots()
        .map((ids) {
      final List<String> data = [];
      for (var e in ids.data()!['product_id']) data.add(e);
      return data;
    });
  }

  deleteItemFromBeg(String prodId) async {
    return await fireStore
        .doc('users/${instance.currentUser!.uid}/beg/$prodId')
        .delete();
  }

  Future<List<ProductModel?>> favoritesList() async {
    return await fireStore.collection('products').get().then((value) {
      List<ProductModel> favList = [];
      for (var e in value.docs)
        if (favoritesId.contains(e.id))
          favList.add(ProductModel.fromJson(e.data()));

      return favList;
    });
  }

  // getTotalPrice() {
  //   double total = 0.0;
  //   for (var p in beg) {
  //     total += double.parse(p.price!);
  //   }
  //   total;
  // }
  getTotalPrice() {
    total.value = 0.0;
    for (BegModel i in beg) total.value += double.parse(i.price!);
    // print("Price : ${i.name} ${i.price}");

    // print(total.value);
  }

  // addPrice(double newPrice) {
  //   total.value += newPrice;
  // }

  Future<bool> addAddress(String name, String addressName, String city,
      String zipCode, bool isActive) async {
    isRequesting.toggle();
    final address =
        ShippingModel.toModel(name, addressName, city, zipCode, isActive);
    final result = await FireBaseCollection.addingShippingAddress(address);
    return result;
  }

  Stream<List<ShippingModel>> shippingAddresssStream() {
    return fireStore
        .collection("users/${instance.currentUser!.uid}/address")
        // .orderBy("is_active", descending: true)
        .snapshots()
        .map((ids) {
      final List<ShippingModel> data = [];
      for (var e in ids.docs) {
        final address = ShippingModel.fromJson(e.data());
        data.add(address);
      }
      return data;
    });
  }

  makeActive(String activeID, String toBeAactiveID, bool currentState) async {
    return await FireBaseCollection.makeActiveAddress(
        activeID, toBeAactiveID, currentState);
  }

  Stream<List<DeliveryModel>> getDeliveryMethodAsSteam() {
    return fireStore.collection('delivery_method').snapshots().map((event) =>
        event.docs.map((e) => DeliveryModel.fromJson(e.data())).toList());
  }
}
