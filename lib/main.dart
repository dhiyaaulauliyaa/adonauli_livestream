import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'core/themes/site_color.dart';
import 'globals.dart' as globals;
import 'presentation/screens/desktop/desktop_home_screen.dart';
import 'presentation/screens/mobile/mobile_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livestream | The Wedding of Nauli and Ado',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: SiteColor.background,
        fontFamily: 'Manouche',
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: SiteColor.black,
          ),
        ),
      ),
      home: ResponsiveBuilder(
        breakpoints: const ScreenBreakpoints(
          desktop: 1280,
          tablet: 800,
          watch: 250,
        ),
        builder: (context, sizeInfo) {
          log('Size Changed: ${sizeInfo.deviceScreenType}');
          log('Size Changed: ${sizeInfo.screenSize}');

          var app = ScreenTypeLayout(
            breakpoints: const ScreenBreakpoints(
              desktop: 1280,
              tablet: 800,
              watch: 250,
            ),
            desktop: const DesktopHomeScreen(),
            mobile: OrientationLayoutBuilder(
              portrait: (context) => const MobileHomeScreen(),
              landscape: (context) {
                globals.deviceType = DeviceScreenType.desktop;
                return const DesktopHomeScreen();
              },
            ),
          );

          if (sizeInfo.deviceScreenType == DeviceScreenType.desktop) {
            globals.deviceType = DeviceScreenType.desktop;
          } else if (sizeInfo.deviceScreenType == DeviceScreenType.tablet) {
            globals.deviceType = DeviceScreenType.desktop;
          } else if (sizeInfo.deviceScreenType == DeviceScreenType.mobile) {
            globals.deviceType = DeviceScreenType.mobile;
          }
          return app;
        },
      ),
    );
  }
}
