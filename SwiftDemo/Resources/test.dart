import 'dart:async';
import 'dart:io';
// import 'dart:core';

Completer<String> _resultCompleter;
Future<String> testAsync() async {
  print('testAsync');
  // await Future.delayed(Duration(seconds: 2));
  // List a = [];
  // print('${a[1]}');
  // return null;
  _resultCompleter = Completer();
  // Future.delayed(Duration(seconds: 1), (){
  //   _resultCompleter.complete('xxx');
  // });
    
  return _resultCompleter.future;
}

void main(){
  runZoned<Future<void>>(
    () async {
      //同步的初始化
      await main2();
    },
    onError: (error, stackTrace) {
      print('dart_error: error: $error, stack: $stackTrace');
    },
  );
}

void main2() async{
  try{
    var a = await testAsync();
    print('a = $a');
    await Future.delayed(Duration(seconds: 5));
    print('bbb');
  }catch(e){
    print('ccc: $e');
  }
  
}

