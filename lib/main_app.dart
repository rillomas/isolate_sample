@HtmlImport('main_app.html')

library main_app;

import "dart:html";
import "dart:async";
import "dart:isolate";
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:logging/logging.dart';

@PolymerRegister('main-app')
class MainApp extends PolymerElement {
  MainApp.created() : super.created();

  void ready() {
    Logger.root.info("main-app ready");
    _startIsolate();
  }

  _startIsolate() async {
    var fromIsolate = new ReceivePort();
    SendPort toIsolate;
    await Isolate.spawnUri(Uri.parse("heart_beater.dart"), [], fromIsolate.sendPort);
    fromIsolate.listen((msg) {
      if (toIsolate == null && msg is SendPort) {
        toIsolate = msg;
        toIsolate.send("start");
        Logger.root.info("started heartbeater");
      } else {
        var now = new DateTime.now();
        Logger.root.info("$msg at $now");
      }
    });
  }
}
