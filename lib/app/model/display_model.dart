class DisplayProduct {
  String? subTitle;
  List<String>? productList;
  String? title;

  DisplayProduct(
      {required this.subTitle, required this.productList, required this.title});

  DisplayProduct.fromJson(Map<String, dynamic> json) {
    subTitle = json['sub_title'];
    productList = json['product_list'].cast<String>();
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_title'] = this.subTitle;
    data['product_list'] = this.productList;
    data['title'] = this.title;
    return data;
  }
}
