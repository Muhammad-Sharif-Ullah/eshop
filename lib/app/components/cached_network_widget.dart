import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CachedNetworkWidget extends StatelessWidget {
  const CachedNetworkWidget({
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
      child: CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: url,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        placeholder: (context, url) => CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
