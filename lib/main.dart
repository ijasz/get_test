import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/main.dart';
import 'package:ocean_project/mobileview/main.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'desktopview/Components/course_enrole.dart';
import 'desktopview/route/routing.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: kfontname),
      debugShowCheckedModeBanner: false,
      home: ScreenTypeLayout(),
    ),
  );
}

class ScreenTypeLayout extends StatefulWidget {
  // Mobile will be returned by default
  @override
  _ScreenTypeLayoutState createState() => _ScreenTypeLayoutState();
}

class _ScreenTypeLayoutState extends State<ScreenTypeLayout> {
  final Widget mobile = OceanMobileView();
  final Widget tablet = OceanMobileView();
  final Widget desktop = OceanLive();
  Widget route;
  sessionfunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = (prefs.getString('user') ?? null);
    print("${username}mainpage name");

    route = username != null
        ? CoursesView(
            userID: username,
          )
        : OceanLive();
    print("${username}session mainpage");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionfunction();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Routing()),
        ChangeNotifierProvider(create: (context) => SliderContent()),
        ChangeNotifierProvider(create: (context) => UpcomingModel()),
        ChangeNotifierProvider(
          create: (context) => CourseProvide(),
        ),
        ChangeNotifierProvider(create: (context) => SyllabusView()),
        ChangeNotifierProvider(create: (context) => OALive()),
        ChangeNotifierProvider(create: (context) => UserProfiles()),
        ChangeNotifierProvider(create: (context) => FreeWeb()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Gilroy',
        ),
        home: Scaffold(
          body: Consumer<OALive>(
            builder: (context, routing, child) {
              return ResponsiveBuilder(builder: (context, sizingInformation) {
                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.desktop) {
                  print("desktop");
                  if (desktop != null) {
                    print("desktop");
                    return route;
                  }
                }

                // Return mobile layout if nothing else is supplied
                return OceanMobileView();
              });
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
