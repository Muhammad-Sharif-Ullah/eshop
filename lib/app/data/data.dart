import 'package:eshop/app/model/model.dart';

final String assetsPath = "assets/images/all_images/";
final allBaners = [
  AppBanner(image: assetsPath+'banner2.png', text: 'Fashoin Sale'),
  AppBanner(image: assetsPath+'banner2.png', text: 'Street Clothes'),
  AppBanner(image: assetsPath+'banner2.png', text: 'New Collection'),
  AppBanner(image: assetsPath+'banner2.png', text: 'Black'),
  AppBanner(image: assetsPath+'banner2.png', text: "Men's Hoodies"),
];

final saleProducts = [
  ProductShortModel(productId: 1, image: [assetsPath+'sale1.png'], brand: 'Dorothy Perkings', prodType: 'Evening Dress', oldPrice: 15, newPrice: 12, likedCount: 4, upperBadge: '-20%'),
  ProductShortModel(productId: 2, image: [assetsPath+'sale2.png'], brand: 'Sitlly', prodType: 'Sport Dress', oldPrice: 22, newPrice: 19, likedCount: 3, upperBadge: '-15%'),
  ProductShortModel(productId: 3, image: [assetsPath+'sale3.png'], brand: 'Dorothy Perkings', prodType: 'Sport Dress', oldPrice: 100, newPrice: 89, likedCount: 5, upperBadge: '-19%'),
  ProductShortModel(productId: 4, image: [assetsPath+'sale1.png'], brand: 'Dorothy Perkings', prodType: 'Evening Dress', oldPrice: 15, newPrice: 12, likedCount: 4, upperBadge: '-20%'),
  ProductShortModel(productId: 5, image: [assetsPath+'sale2.png'], brand: 'Sitlly', prodType: 'Sport Dress', oldPrice: 22, newPrice: 19, likedCount: 3, upperBadge: '-15%'),
  ProductShortModel(productId: 6, image: [assetsPath+'sale3.png'], brand: 'Dorothy Perkings', prodType: 'Sport Dress', oldPrice: 100, newPrice: 89, likedCount: 5, upperBadge: '-19%'),
  ProductShortModel(productId: 7, image: [assetsPath+'sale1.png'], brand: 'Dorothy Perkings', prodType: 'Evening Dress', oldPrice: 15, newPrice: 12, likedCount: 4, upperBadge: '-20%'),
  ProductShortModel(productId: 8, image: [assetsPath+'sale2.png'], brand: 'Sitlly', prodType: 'Sport Dress', oldPrice: 22, newPrice: 19, likedCount: 3, upperBadge: '-15%'),
  ProductShortModel(productId: 9, image: [assetsPath+'sale3.png'], brand: 'Dorothy Perkings', prodType: 'Sport Dress', oldPrice: 100, newPrice: 89, likedCount: 5, upperBadge: '-19%'),
];


final newProducts = [
  ProductShortModel(productId: 10, image: [assetsPath+'new1.png'], brand: 'OVS', prodType: 'Blouse', oldPrice: 0, newPrice: 30, likedCount: 0, upperBadge: 'New'),
  ProductShortModel(productId: 11, image: [assetsPath+'new2.png'], brand: 'Mango Boy', prodType: 'T-Shirt Sailing', oldPrice: 0, newPrice: 50, likedCount: 0, upperBadge: 'New'),
  ProductShortModel(productId: 12, image: [assetsPath+'new1.png'], brand: 'Cool', prodType: 'Jeans', oldPrice: 0, newPrice: 45, likedCount: 0, upperBadge: 'New'),
  ProductShortModel(productId: 13, image: [assetsPath+'new2.png'], brand: 'OVS', prodType: 'Blouse', oldPrice: 0, newPrice: 30, likedCount: 0, upperBadge: 'New'),
  ProductShortModel(productId: 14, image: [assetsPath+'new1.png'], brand: 'Mango Boy', prodType: 'T-Shirt Sailing', oldPrice: 0, newPrice: 50, likedCount: 0, upperBadge: 'New'),
  ProductShortModel(productId: 15, image: [assetsPath+'new2.png'], brand: 'Cool', prodType: 'Jeans', oldPrice: 0, newPrice: 45, likedCount: 0, upperBadge: 'New'),
];

final allReview = [
  ReviewsModel(avatar: assetsPath+ 'avatar.png', productId: 1, userName: "Helena More", date: DateTime.now(), reviewGive: 4, reviewLiked: 4, reviewImages: '', review: """The dress is great! Very classy and comfortable. It fit perfectly! I'm 5'7" and 130 pounds. I am a 34B chest. This dress would be too long for those who are shorter but could be hemmed. I wouldn't recommend it for those big chested as I am smaller chested and it fit me perfectly. The underarms were not too wide and the dress was made well."""),
  ReviewsModel(avatar: assetsPath+ 'avatar1.png', productId: 2, userName: "Unknow", date: DateTime.now(), reviewGive: 3, reviewLiked: 1, reviewImages: '', review: """The dress is great! Very classy and comfortable. It fit perfectly! I'm 5'7" and 130 pounds. I am a 34B chest. This dress would be too long for those who are shorter but could be hemmed. I wouldn't recommend it for those big chested as I am smaller chested and it fit me perfectly. The underarms were not too wide and the dress was made well."""),
  ReviewsModel(avatar: assetsPath+ 'avatar.png', productId: 3, userName: "Helena More", date: DateTime.now(), reviewGive: 4, reviewLiked: 1, reviewImages: '', review: """The dress is great! Very classy and comfortable. It fit perfectly! I'm 5'7" and 130 pounds. I am a 34B chest. This dress would be too long for those who are shorter but could be hemmed. I wouldn't recommend it for those big chested as I am smaller chested and it fit me perfectly. The underarms were not too wide and the dress was made well."""),
];