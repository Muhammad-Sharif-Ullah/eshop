

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/app/model/model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TopSlider extends StatelessWidget {
  const TopSlider({
    Key? key,
    required this.sliders,
  }) : super(key: key);

  final List<AppBanner> sliders;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        autoPlay: true,
        height: 200,
        // aspectRatio: 16 / 9,
        aspectRatio: 2.0,
        viewportFraction: 0.9,
        // reverse: true
        // initialPage: 2,
      ),
      itemCount: sliders.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Container(
            child: Stack(
              children: [
                Image.asset(
                  sliders[itemIndex].image,
                  fit: BoxFit.cover,
                  height: 200,
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black12,
                        Colors.black26,
                      ],
                      stops: [0.8, 0.9],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: Text(
                    sliders[itemIndex].text,
                    style:
                    context.textTheme.headline1?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
