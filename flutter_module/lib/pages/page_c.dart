import 'package:flutter/material.dart';

class DemoPageC extends StatefulWidget {
  @override
  _DemoPageCState createState() => _DemoPageCState();
}

class _DemoPageCState extends State<DemoPageC> {
  @override
  Widget build(BuildContext context) {
    print('param = ${ModalRoute.of(context).settings.arguments}');
    return Scaffold(
      appBar: AppBar(
        title: Text('pageC'),
      ),
    );
  }
}
