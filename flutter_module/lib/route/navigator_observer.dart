import 'package:flutter/cupertino.dart';

class MyNavigatorObserver extends NavigatorObserver {
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('didPush');
  }

  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('didPop');
  }

  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('didRemove');
  }

  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print('didReplace');
  }

  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('didStartUserGesture');
  }

  void didStopUserGesture() {
    print('didStopUserGesture');
  }
}
