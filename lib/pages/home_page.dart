import 'package:flutter/material.dart';
import '../components/banner_ui.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../http/address.dart';
import '../http/http.dart';
import '../http/result_data.dart';
import '../http/data_helper.dart';

import 'dart:convert';

import '../components/grid_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int page = 1;
  List newsList = [];
  List list = [];
  void initState() {
    super.initState();
    _testRequest();
  }

  void _testRequest() async {
    var params = DataHelper.getBaseMap();
    params.clear();
    params['type'] = 1;
    params['page'] = page;
    print(params);
    ResultData res = await HttpManager.getInstance()
        .get(Address.BASE_URL + 'information', params: params);
    setState(() {
      if (res.isSuccess) {
        String data = json.encode(res.data['data']);
        // 设置热销商品数据列表
        setState(() {
          newsList = json.decode(data)['list'];
          list.addAll(newsList);
          page++;
        });
      } else {
        //错误情况处理
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(750, 1336),
        builder: () => Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: HomeAppBar(),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      height: 150,
                      child: SwiperPage()
                      // decoration: BoxDecoration(
                      //     color: Colors.lightBlue.shade50,
                      //     borderRadius: BorderRadius.circular(10),
                      //     image: const DecorationImage(
                      //         image: AssetImage('assets/images/banner.jpg'),
                      //         fit: BoxFit.cover)),
                      )),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: Container(
                    // padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    height: 80,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        tabListItem(Icons.calendar_today, '每日推荐'),
                        tabListItem(Icons.dark_mode, '私人FM'),
                        tabListItem(Icons.topic, '歌单'),
                        tabListItem(Icons.list, '排行榜'),
                        tabListItem(Icons.video_camera_back, '直播'),
                        tabListItem(Icons.music_note, '数字专辑'),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: list.length,
                      itemBuilder: _getGridData,
                      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                      // staggeredTileBuilder: (int index) =>
                      // StaggeredTile.count(2, index.isEven ? 2 : 1),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                    // child: MaterialButton(
                    //     color: Colors.blue,
                    //     textColor: Colors.white,
                    //     child: Text('点我'),
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, '/list',
                    //           arguments: {"id": '123'});
                    //       // var hide = FLToast.loading(text: 'Loading...');
                    //       // hide();
                    //     }),
                    alignment: Alignment.topCenter,
                    // decoration: BoxDecoration(color: Colors.red.shade100),
                  ))
            ],
          ),
        )
    );
  }
  //自定义方法
  Widget _getGridData(context, index) {
    return TileCard(
      img: list[index]['cover'],
      title: list[index]['title']
    );
  }
}

class tabListItem extends StatelessWidget {
  IconData icon;
  String text;
  tabListItem(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 0, right: 30, top: 0, bottom: 0),
        child: Column(
          children: <Widget>[
            Container(
              child: Icon(
                this.icon,
                color: Colors.red.shade400,
                size: 20,
              ),
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepOrange.shade50),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(this.text,
                style: const TextStyle(fontSize: 12, color: Colors.black54))
          ],
        ));
  }
}

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      const Icon(Icons.list),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/search');
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => SearchPage()));
              },
              child: Container(
                width: 300,
                height: 35,
                child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      '请输入搜索内容',
                      style: TextStyle(
                          color: Colors.grey.shade500, fontSize: 14, height: 2),
                    )),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.grey.shade200),
              ),
            ),
          ),
      const Icon(Icons.list),
    ]);
  }
}
