import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'site_color.dart';

class SiteInputDecoration {
  InputDecoration defaultStyle({
    required String hint,
    DeviceScreenType deviceType = DeviceScreenType.desktop,
  }) {
    double _calcFontSize() {
      switch (deviceType) {
        case DeviceScreenType.desktop:
          return 32.sp;
        case DeviceScreenType.tablet:
          return 32.sp;
        case DeviceScreenType.mobile:
          return 20.sp;
        default:
          return 24.sp;
      }
    }

    return InputDecoration(
      /* Hint */
      hintText: hint,
      hintStyle: TextStyle(
        fontFamily: 'ManoucheCondensed',
        fontWeight: FontWeight.w300,
        fontSize: _calcFontSize(),
        color: Colors.grey[400],
      ),

      /* Border */
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: SiteColor.darkPink),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: SiteColor.darkPink),
      ),
    );
  }
}
