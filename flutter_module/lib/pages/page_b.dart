import 'package:flutter/material.dart';

class DemoPageB extends StatefulWidget {
  @override
  _DemoPageBState createState() => _DemoPageBState();
}

class _DemoPageBState extends State<DemoPageB> {
  @override
  Widget build(BuildContext context) {
    print('param = ${ModalRoute.of(context).settings.arguments}');
    return Scaffold(
      appBar: AppBar(
        title: Text('pageB'),
      ),
    );
  }
}
