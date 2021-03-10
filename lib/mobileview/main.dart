import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/mobileview/route/routing.dart';
import 'package:ocean_project/mobileview/screen/menubar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(OceanMobileView());
}

class OceanMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Routing(),
        child: MaterialApp(
          theme: ThemeData(fontFamily: kfontname),
          home: Navbar(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
