import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/themes/site_color.dart';
import 'presentation/screens/home_screen.dart';

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
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_) {
          return const HomeScreen();
        },
      ),
    );
  }
}
