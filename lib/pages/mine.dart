import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../http/address.dart';
import '../http/http.dart';
import '../http/result_data.dart';
import '../http/data_helper.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

EasyRefreshController _controller;

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<MinePage> {
  List<Map> newsList = [];
  void initState() {
    super.initState();

    _controller = EasyRefreshController();

  }

  void _testRequest() async {
    var params = DataHelper.getBaseMap();
    params.clear();
    //apikey=0df993c66c0c636e29ecbb5344252a4a&start=0&count=10
    params['type'] = 1;
    params['page'] = page;
    print(params);
    ResultData res =
    await HttpManager.getInstance().get(Address.BASE_URL+'information', params: params);
    setState(() {
      if(res.isSuccess){
         List<Map> newsList = (res.data.data.list as List).cast();
         // 设置热销商品数据列表
         setState(() {
           newsList.addAll(newsList);
           print(newsList);
           page++;
         });
       }else{
        //错误情况处理
       }
    });

  }

  int page = 1;


  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      // 是否开启控制结束加载
      enableControlFinishLoad: false,
      // 控制器
      controller: _controller,
      // 自定义顶部上啦加载
      footer: ClassicalFooter(
        bgColor: Colors.white,
        //  更多信息文字颜色
        infoColor: Colors.red,
        // 字体颜色
        textColor: Colors.red,
        // 加载失败时显示的文字
        loadText: '加载失败',
        // 没有更多时显示的文字
        noMoreText: '',
        // 是否显示提示信息
        showInfo: false,
        // 正在加载时的文字
        loadingText: '加载中',
        // 准备加载时显示的文字
        loadReadyText: '准备加载时显示的文字',
        // 加载完成显示的文字
        loadedText: '加载完成显示的文字',
      ),
      child: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: _getListData
      ),
      // 上拉加载事件回调
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          // 加载热销商品
          _testRequest();
          // 结束加载
          _controller.finishLoad();
        });
      },

      //下拉刷新事件回调 【本项目中没有用到】
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2), () {
          // 事件处理
          // 重置刷新状态 【没错，这里用的是resetLoadState】
          _controller.resetLoadState();
        });
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //自定义方法
  Widget _getListData(context,index){
    return ListTile(
        title: Text(newsList[index]["title"]),  //每次取出index的索引对应的数据返回
    );
  }
}

_getData() async {
  // var url = Uri.parse('http://jd.itying.com/api/httpGet');
  // var response = await http.get(url);
  // print("response status: ${response.statusCode}");
  // print("response body: ${response.body}");
}


class ListItem extends StatelessWidget {
  Map item;
  ListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 0, right: 30, top: 0, bottom: 0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            Text('${this.item['title']}',
                style: const TextStyle(fontSize: 12, color: Colors.black54))
          ],
        ));
  }
}
