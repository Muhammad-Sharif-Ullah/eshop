
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    required this.url,
    required this.radius,
  }) : super(key: key);

  final String url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.greenAccent, width: 3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100000000),
        child: CachedNetworkImage(
          imageUrl: url,
          height: radius,
          width: radius,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          fadeInCurve: Curves.bounceIn,
          progressIndicatorBuilder:
              (context, url, downloadProgress) =>
              CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
