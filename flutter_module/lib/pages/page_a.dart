import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoPageA extends StatefulWidget {
  @override
  _DemoPageAState createState() => _DemoPageAState();
}

class _DemoPageAState extends State<DemoPageA> {
  @override
  Widget build(BuildContext context) {
    print('param = ${ModalRoute.of(context).settings.arguments}');
    return Scaffold(
      appBar: AppBar(
        title: Text('pageA'),
        brightness: Brightness.light,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
//                Channels.commonCallToNative('backToNativeView');
                SystemNavigator.pop(animated: true);
              },
              child: Container(
                height: 60.0,
                alignment: Alignment.center,
                child: Text('backToNative'),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Text('other'),
                alignment: Alignment.center,
                height: 60.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
