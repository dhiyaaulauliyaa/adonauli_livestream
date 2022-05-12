import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../globals.dart' as globals;
import 'site_color.dart';

class SiteFont {
  static TextStyle primary({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w300,
    Color color = SiteColor.black,
    double letterSpacing = -0.4,
    double? height,
  }) {
    var deviceType = globals.deviceType;
    double defaultHeight() {
      if (deviceType == DeviceScreenType.desktop && !kIsWeb) {
        return 2.4;
      } else {
        return 1.4;
      }
    }

    double responsivenessMultiplier() {
      if (deviceType == DeviceScreenType.mobile) {
        return 1.sp;
      } else {
        return 1.sp;
      }
    }

    return TextStyle(
      fontFamily: 'Roobert',
      fontWeight: fontWeight,
      fontSize: fontSize * responsivenessMultiplier(),
      letterSpacing: letterSpacing * responsivenessMultiplier(),
      height: (height ?? defaultHeight()) * responsivenessMultiplier(),
      color: color,
    );
  }
}
