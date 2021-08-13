import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class SwiperPage extends StatefulWidget {
  SwiperPage({Key? key}) : super(key: key);

  @override
  _SwiperPageState createState() => _SwiperPageState();
}

class _SwiperPageState extends State<SwiperPage> {
  List<Image> imgs = [
    Image.asset(
      "assets/images/banner.jpg",
      width: 100.0,
    ),
    Image.asset(
      "assets/images/banner.jpg",
      width: 100.0,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Swiper(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return imgs[index];
        },
        autoplay: true,
      ),
    );
  }
}
