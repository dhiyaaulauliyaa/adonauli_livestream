import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/img_dir.dart';

class DesktopHomeScreen extends StatelessWidget {
  const DesktopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      builder: (child) => Scaffold(
        body: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFEFED),
                Color(0xFFF2FCFF),
              ],
            ),
          ),
          child: Stack(
            children: [
              Image.asset(
                ImgDir.dPattern,
                width: 1.sw,
                height: 1.sh,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
    );
  }
}
