@HtmlImport('main_app.html')

library main_app;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:logging/logging.dart';

@PolymerRegister('main-app')
class MainApp extends PolymerElement {
  MainApp.created() : super.created();

  void ready() {
    Logger.root.info("main-app ready");
  }
}
