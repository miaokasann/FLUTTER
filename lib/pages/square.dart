import 'package:flutter/material.dart';

class SquarePage extends StatelessWidget {
  const SquarePage({Key? key}) : super(key: key);

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
      body: const Text('广场'),
    );
  }
}
