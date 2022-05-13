import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/themes/site_color.dart';

class SiteButton extends StatelessWidget {
  SiteButton({
    Key? key,
    this.text = 'SUBMIT',
    this.height,
    this.width,
    this.onTap,
    this.style,
    this.fontSize,
    this.enable = true,
    this.enableDebounce = true,
    this.debounceDuration = const Duration(seconds: 5),
  }) : super(key: key);

  final double? height;
  final double? width;

  final String text;

  final double? fontSize;
  final ButtonStyle? style;

  final void Function()? onTap;

  final bool enableDebounce;
  final Duration debounceDuration;

  final ValueNotifier<bool> _enable = ValueNotifier(true);
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(500.r),
        child: SizedBox(
          height: height ?? _calcSize(context).height,
          width: width ?? _calcSize(context).width,
          child: !enable
              ? ElevatedButton(
                  onPressed: _onTap,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const StadiumBorder(),
                    primary: SiteColor.lightGrey,
                    onPrimary: Colors.grey[700],
                    side: BorderSide(
                      color: SiteColor.grey,
                      width: 3.sp,
                    ),
                  ),
                  child: _buildText(context),
                )
              : ElevatedButton(
                  onPressed: _onTap,
                  style: style ??
                      ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const StadiumBorder(),
                        primary: SiteColor.pink,
                        onPrimary: Colors.grey[700],
                        side: BorderSide(
                          color: SiteColor.darkPink,
                          width: 3.sp,
                        ),
                      ),
                  child: _buildText(context),
                ),
        ),
      ),
    );
  }

  Text _buildText(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'ManoucheExpanded',
        fontWeight: FontWeight.w700,
        fontSize: fontSize ?? _calcFontSize(context),
        color: Colors.white,
      ),
    );
  }

  void _onTap() {
    /* Run Function */
    if (_enable.value && enable) {
      /* Disable Button */
      _enable.value = false;

      /* Run Function */
      onTap?.call();

      /* Reenable Button */
      if (enable) {
        Future.delayed(
          const Duration(seconds: 2),
          () => _enable.value = true,
        );
      }
    }

    /* Button Disabled */
    else {
      log('Clicked');
    }
  }

  Size _calcSize(BuildContext context) {
    DeviceScreenType deviceType = getDeviceType(MediaQuery.of(context).size);

    switch (deviceType) {
      case DeviceScreenType.desktop:
        return Size(260.w, 100.h);
      case DeviceScreenType.tablet:
        return Size(260.w, 100.h);
      case DeviceScreenType.mobile:
        return Size(200.w, 64.h);
      default:
        return Size(260.w, 100.h);
    }
  }

  double _calcFontSize(BuildContext context) {
    DeviceScreenType deviceType = getDeviceType(MediaQuery.of(context).size);

    switch (deviceType) {
      case DeviceScreenType.desktop:
        return 24.sp;
      case DeviceScreenType.tablet:
        return 24.sp;
      case DeviceScreenType.mobile:
        return 18.sp;
      default:
        return 24.sp;
    }
  }
}
