import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: SafeArea(
          top: true,
          child: Offstage(),
        ),
      ),
      body: const Text('搜索页面'),
    );
  }
}
