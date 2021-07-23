class AppBanner {
  String image;
  String text;

  AppBanner({required this.image, required this.text});
}

class ProductShortModel {
  final int productId;
  final List<String> image;
  final String brand;
  final String prodType;
  final double oldPrice;
  final double newPrice;
  final int likedCount;
  final String upperBadge;

  ProductShortModel({
    required this.productId,
    required this.image,
    required this.brand,
    required this.prodType,
    required this.oldPrice,
    required this.newPrice,
    required this.likedCount,
    required this.upperBadge,
  });
}

class ReviewsModel {
  final int productId;
  final String avatar;
  final String userName;
  final DateTime date;
  final int reviewGive;
  final int reviewLiked;
  final String reviewImages;
  final String review;

  ReviewsModel(
      {required this.avatar,
        required this.productId,
      required this.userName,
        required this.review,
      required this.date,
      required this.reviewGive,
      required this.reviewLiked,
      required this.reviewImages});
}
