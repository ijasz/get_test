// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:google_maps/google_maps.dart' hide Icon, Padding;

Widget getMap() {
  String htmlId = "7";

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    final myLatlng = new LatLng(11.952225916443883, 79.8299675401406);

    final mapOptions = new MapOptions()
      ..zoom = 16
      ..center = new LatLng(11.952225916443883, 79.8299675401406);

    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none';

    final map = new GMap(elem, mapOptions);

    Marker(MarkerOptions()
      ..position = myLatlng
      ..map = map
      ..title = 'OceanAcadamey');

    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}
