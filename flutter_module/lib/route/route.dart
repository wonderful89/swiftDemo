import 'package:flutter/widgets.dart';
import 'package:flutter_module/pages/page_a.dart';
import 'package:flutter_module/pages/page_b.dart';
import 'package:flutter_module/pages/page_c.dart';

class RoutePages {
  static String pageA = 'pageA';
  static String pageB = 'pageB';
  static String pageC = 'pageC';
  static String pageD = 'pageD';
}

class Routes {
  static final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  static Map pageRoutes = {
    RoutePages.pageA: (context) => DemoPageA(),
    RoutePages.pageB: (context) => DemoPageB(),
    RoutePages.pageC: (context) => DemoPageC(),
  };
}
