import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/app/firebase_repository/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureImageWidget extends StatelessWidget {
  const FutureImageWidget({
    Key? key,
    required this.url,
    required this.height,
    required this.width,
  }) : super(key: key);

  final String url;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: height, //184
        width: width, //200
        child: buildFutureBuilder(url),
      ),
    );
  }

  FutureBuilder<String> buildFutureBuilder(String url) {
    return FutureBuilder<String>(
      future: FireBaseStorage.getDownloadLink(url),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) return buildCachedNetworkImage(snapshot);
        return CupertinoActivityIndicator();
      },
    );
  }

  CachedNetworkImage buildCachedNetworkImage(AsyncSnapshot<dynamic> snapshot) {
    return CachedNetworkImage(
      imageUrl: snapshot.data,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CupertinoActivityIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
