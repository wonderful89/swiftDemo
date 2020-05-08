import 'package:flutter/widgets.dart';
import 'package:flutter_module/pages/page_a.dart';
import 'package:flutter_module/pages/page_b.dart';
import 'package:flutter_module/pages/page_c.dart';

class Routes {
  static final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  static Map pageRoutes = {
    'pageA': (context) => DemoPageA(),
    'pageB': (context) => DemoPageB(),
    'pageC': (context) => DemoPageC(),
  };
}
