import 'package:flutter/material.dart';

class MusicListPage extends StatelessWidget {
  final arguments;
  MusicListPage({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(arguments['id']),
    );
  }
}
