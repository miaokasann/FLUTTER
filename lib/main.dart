import 'package:flutter/material.dart';

//首页
import 'pages/home_page.dart';
//广场
import 'package:flutterdemo/pages/square.dart';
//我的
import 'package:flutterdemo/pages/mine.dart';

//路由
import 'routes/router.dart';


import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: IndexPage(),
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      // initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IndexState();
  }
}

class _IndexState extends State<IndexPage> {
  int currentIndex = 0;
  // final List<BottomNavigationBarItem> bottomNavItems = ;
  final pages = [HomePage(), SquarePage(), MinePage()];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: SafeArea(
            top: true,
            child: Offstage(),
          ),
        ),
        // appBar: AppBar(
        //     backgroundColor: Colors.white, title: HomeAppBar(), elevation: 1),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: currentIndex == 0 ? Colors.red : Colors.grey),
              label: "首页",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.message,
                  color: currentIndex == 1 ? Colors.red : Colors.grey),
              label: "广场",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.person,
                  color: currentIndex == 2 ? Colors.red : Colors.grey),
              label: "我的",
            )
          ],
          currentIndex: currentIndex,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          selectedLabelStyle: const TextStyle(color: Colors.red),
          selectedItemColor: Colors.red,
          // type: BottomNavigationBarType.shifting,
          onTap: (index) {
            _changePage(index);
          },
        ),
      )
    );
  }

  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}

class homeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: layoutDemo(),
      // const Text('我是一个文本',
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //         fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30)),
      height: double.infinity,
      width: double.infinity,
      //容器背景颜色
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        // border: Border.all(color: Colors.blue, width: 2)
      ),
    );
  }
}

class layoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.7,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/row.png',
              fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/row.png',
              fit: BoxFit.cover),
        ),
      ],
    );
  }
}

class rowContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: IconContainer(Icons.home, color: Colors.red.shade100),
        ),
        Expanded(
          flex: 2,
          child: IconContainer(Icons.search, color: Colors.grey),
        )
      ],
    );
  }
}

class IconContainer extends StatelessWidget {
  IconData icon;
  Color color;
  double size;
  IconContainer(this.icon, {this.color = Colors.red, this.size = 32});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      // decoration: const BoxDecoration(
      //     borderRadius: BorderRadius.all(Radius.circular(1))),
      color: this.color,
      child: Center(
        child: Icon(this.icon, size: this.size, color: Colors.white),
      ),
    );
  }
}
