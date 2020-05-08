import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_module/route/route.dart';

class BindingObServer extends WidgetsBindingObserver {
  Future<bool> didPopRoute() async {
    print('didPopRoute');
    return false;
  }

  Future<bool> didPushRoute(String route) async {
    print('didPushRoute: $route');
    Map map = jsonDecode(route);
    String pageName = map['pageName'];
    String pushMode = map['pageName'];
    Map arguments = map;
    var navigator = Routes.globalKey.currentState;
    var result;
    switch (pushMode ?? '') {
      case 'push':
        result = await navigator.pushNamed(pageName, arguments: arguments);
        break;
      case 'pushReplacement':
        result = await navigator.pushReplacementNamed(pageName, arguments: arguments);
        break;
      case 'pushAndRemoveAll':
        result = await navigator.pushNamedAndRemoveUntil(pageName, (Route<dynamic> route) => false, arguments: arguments);
        break;
      case 'popAndPush':
        result = await navigator.popAndPushNamed(pageName, arguments: arguments);
        break;
      default:
        result = await navigator.pushNamed(pageName, arguments: arguments);
        break;
    }
    return result;
  }

  void didChangeMetrics() {}

  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('didChangeAppLifecycleState: $state');
  }
}
