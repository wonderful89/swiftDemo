import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/channels.dart';
import 'package:flutter_module/route/route.dart';

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
              onTap: () {
                Routes.globalKey.currentState.pushNamed(RoutePages.pageA, arguments: {'tes44': '34444'});
              },
              child: Container(
                child: Text('push flutter view'),
                alignment: Alignment.center,
                height: 60.0,
              ),
            ),
            Divider(),
            Divider(),
            GestureDetector(
              onTap: () {
                Channels.commonCallToNative('pageRoute', params: {'test22': '333', 'name': 'UIViewController'});
              },
              child: Container(
                child: Text('push native view(UIViewControler)'),
                alignment: Alignment.center,
                height: 60.0,
              ),
            ),
            GestureDetector(
              onTap: () {
                Channels.commonCallToNative('pageRoute', params: {'test22': '333', 'name': 'FlutterViewController', 'flutterName': 'pageC'});
              },
              child: Container(
                child: Text('push native view(FlutterViewController)'),
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
