import 'dart:html';
import 'dart:ui' as ui;

// ignore: camel_case_types
class platformViewRegistry {
  static registerViewFactory(String viewId, dynamic cb) {
    ui.platformViewRegistry.registerViewFactory(viewId, cb);
    final element = DivElement()
      ..id = viewId
      ..style.height = '1000px';
    return element;
  }
}
