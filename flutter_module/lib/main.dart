import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/channels.dart';
import 'package:flutter_module/route/binding_observer.dart';
import 'package:flutter_module/route/navigator_observer.dart';
import 'package:flutter_module/route/route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized().addObserver(BindingObServer());
  runZoned(() async {
    Channels.setup();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.red,
      statusBarBrightness: Brightness.light,
    ));
    runApp(MyApp());
  }, onError: (error, stackTrace) {
    print('global error = $error, stack = $stackTrace}');
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        platform: TargetPlatform.iOS,
        brightness: Brightness.light,
      ),
      home: MyHomePage(),
      navigatorObservers: [MyNavigatorObserver()],
      navigatorKey: Routes.globalKey,
      initialRoute: 'pageA',
      onGenerateRoute: (RouteSettings settings) {
        var func = Routes.pageRoutes[settings.name];
        if (func != null) {
          return MaterialPageRoute(settings: settings, builder: func);
        }
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => Container(
                  child: Text('未定义的路由'),
                ));
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
