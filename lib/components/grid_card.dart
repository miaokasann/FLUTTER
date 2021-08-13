import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TileCard extends StatelessWidget {
  final String? img;
  final String? title;
  final String? author;
  final String? authorUrl;
  final String? type;
  final double? worksAspectRatio;
  TileCard(
      {this.img,
        this.title,
        this.author,
        this.authorUrl,
        this.type,
        this.worksAspectRatio});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 960),
      builder: () => Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
            EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
            // color: Colors.deepOrange,
            // width: ScreenUtil().setWidth(50),
            // height: ScreenUtil().setHeight(100),
            child: CachedNetworkImage(
                imageUrl: '$img',
                fit: BoxFit.fitHeight
            ),
          ),
          Container(
            padding:
            EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
            child: Text(
              '$title',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                bottom: ScreenUtil().setWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage('$authorUrl'),
                  radius: ScreenUtil().setWidth(30),
                  // maxRadius: 40.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                  width: ScreenUtil().setWidth(250),
                  child: Text(
                    '$author',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(25),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(80)),
                  child: Text(
                    '${type == 'EXISE' ? '练习' : '其他'}',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(25),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    )
    );
  }
}