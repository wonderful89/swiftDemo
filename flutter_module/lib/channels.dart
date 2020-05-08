import 'package:flutter/services.dart';
import 'package:flutter_module/route/route.dart';

class Channels {
  static const MethodChannel methodChannel = MethodChannel('myplugin/method');
  static const EventChannel eventChannel = EventChannel('myplugin/event');

  static setup() {
    methodChannel.setMethodCallHandler((MethodCall call) async {
      print('in setMockMethodCallHandler $call');
      if (call.method == 'commonCallToFlutter') {
        if (call.arguments is Map) {
          var fun = call.arguments['fun'];
          if (fun == 'flutterCanPop') {
            return Routes.globalKey.currentState.canPop();
          } else if (fun == 'other') {
            return 'other';
          }
        }
      }
      return true;
    });

    eventChannel.receiveBroadcastStream(12345).listen((data) {
      print('receive data $data');
    }, onError: (error) {
      print('receive error: $error');
    });
  }

  static Future<dynamic> commonCallToNative(String funName, {Map params}) async {
    var newMap = params ?? {};
    newMap['fun'] = funName;
    var result = await methodChannel.invokeMethod('commonCallToNative', newMap);
    return result;
  }
}
