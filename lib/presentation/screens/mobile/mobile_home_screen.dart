import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/constants/img_dir.dart';
import '../../../core/constants/svg_dir.dart';
import '../../../core/themes/site_color.dart';
import '../../../core/themes/site_font.dart';
import '../../widgets/rotating_widget.dart';
import '../../widgets/site_button.dart';
import '../../widgets/transition_box.dart';

class MobileHomeScreen extends HookWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  static final DateTime eventStart = DateTime(2022, 05, 15, 07, 30);

  @override
  Widget build(BuildContext context) {
    var show = useState<bool>(false);
    var timer = useState<Timer?>(null);
    var countdown = useState<int>(
      eventStart.difference(DateTime.now()).inSeconds,
    );
    var timeLeft = getCountdown(countdown.value);

    /* Init & Dispose */
    useEffect(() {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          return show.value = true;
        },
      );

      timer.value = Timer.periodic(
        const Duration(seconds: 1),
        (_) => countdown.value = countdown.value - 1,
      );

      return () {
        timer.value?.cancel();
      };
    });

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_) {
        var sidePadding = 20.w;

        return Scaffold(
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
                /* BG */
                Image.asset(
                  ImgDir.mPattern,
                  width: 1.sw,
                  height: 1.sh,
                  fit: BoxFit.cover,
                ),

                /* Illustration */
                AnimatedPositioned(
                  bottom: 0,
                  left: show.value ? 0 : 1.sw,
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.easeOutCubic,
                  child: Image.asset(
                    ImgDir.mIllustration,
                    height: 1.sh,
                    width: 1.sw,
                    fit: BoxFit.cover,
                  ),
                ),

                /* Illustration */
                AnimatedPositioned(
                  left: 0,
                  bottom: 0,
                  // bottom: show.value ? 0 : -1.sw * 0.2,
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.easeOutCubic,
                  child: Container(
                    width: 1.sw,
                    padding: EdgeInsets.all(12.w),
                    alignment: Alignment.center,
                    color: SiteColor.superDarkBlue,
                    child: Text(
                      '© 2022 | Made by Ado & Nauli with Passion & Love',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                /* Content */
                Positioned(
                  top: 0,
                  right: 0,
                  child: _buildContent(
                    context: context,
                    sidePadding: sidePadding,
                    timeLeft: timeLeft,
                    show: show.value,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildContent({
    required BuildContext context,
    required double sidePadding,
    required List<int> timeLeft,
    required bool show,
  }) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* MailStamp */
          Container(
            width: 1.sw,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(
              bottom: sidePadding * 2,
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              clipBehavior: Clip.none,
              children: [
                Image.asset(ImgDir.dMailstamp, width: 1.sw * 0.4),
                Positioned(
                  bottom: -10.h,
                  left: -30.w,
                  child: RotatingWidget(
                    child: SvgPicture.asset(
                      SvgDir.adoNauliStamp,
                      width: 1.sw * 0.175,
                      color: SiteColor.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /* Subtitle */
          TransitionBox(
            show: show,
            startDelay: const Duration(milliseconds: 200 * 1),
            child: Row(
              children: [
                Text(
                  'The wedding of '.toUpperCase(),
                  style: SiteFont.primary(
                    color: SiteColor.darkGrey,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  'ADO & NAULI',
                  style: SiteFont.primary(
                    color: SiteColor.darkGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          /* Title */
          TransitionBox(
            show: show,
            startDelay: const Duration(milliseconds: 200 * 2),
            child: Text(
              'Live Streaming ',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 48.sp,
                letterSpacing: -1.sp,
              ),
            ),
          ),
          SizedBox(height: 10.h),

          /* Dates & Time */
          TransitionBox(
            show: show,
            startDelay: const Duration(milliseconds: 200 * 3),
            child: Row(
              children: [
                Text(
                  'Sunday ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'ManoucheSemiCondensed',
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  '| May 15, 2022 at 07:30 AM',
                  style: TextStyle(
                    fontFamily: 'ManoucheSemiCondensed',
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),

          /* Divider */
          TransitionBox(
            show: show,
            startDelay: const Duration(milliseconds: 200 * 4),
            child: Container(
              height: 2.sp,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              color: SiteColor.black.withOpacity(0.1),
            ),
          ),
          SizedBox(height: 10.h),

          /* Countdown Title */
          TransitionBox(
            startDelay: const Duration(milliseconds: 200 * 5),
            child: Text(
              'Event will be started at',
              style: SiteFont.primary(
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          /* Time Countdown */
          Row(
            children: [
              for (int i = 0; i < countdownTitle.length; i++)
                TransitionBox(
                  offset: -1.5 * i,
                  startDelay: const Duration(milliseconds: 200 * 6),
                  child: CountdownWidget(
                    number: timeLeft[i],
                    title: countdownTitle[i],
                  ),
                )
            ],
          ),
          SizedBox(height: 32.h),

          /* Button */
          TransitionBox(
            direction: Direction.vertical,
            offset: 1,
            startDelay: const Duration(milliseconds: 200 * 7),
            child: SiteButton(
              width: 1.sw * 0.7,
              text: 'Open Link',
              onTap: () => _onTap(context),
            ),
          ),
        ],
      ),
    );
  }

  static final List<String> countdownTitle = [
    'days',
    'hours',
    'mins',
    'secs',
  ];

  List<int> getCountdown(int timeLeft) {
    int d = 0;
    int h = 0;
    int m = 0;
    int s = 0;

    int minToSecs = 60;
    int hourToSecs = minToSecs * 60;
    int dayToSecs = hourToSecs * 24;

    d = timeLeft ~/ dayToSecs;
    h = (timeLeft - (d * dayToSecs)) ~/ 3600;
    m = (timeLeft - (d * dayToSecs) - (h * hourToSecs)) ~/ 60;
    s = timeLeft - (d * dayToSecs) - (h * hourToSecs) - (m * minToSecs);

    if (d < 0) d = 0;
    if (h < 0) h = 0;
    if (m < 0) m = 0;
    if (s < 0) s = 0;

    return [d, h, m, s];
  }

  void _onTap(BuildContext context) {
    if (eventStart.difference(DateTime.now()) < const Duration(hours: 1)) {
      launchUrlString(
        'https://us06web.zoom.us/j/83450573536?pwd=UktqR2k5Q0QwR1I3M0JIbjdKNFVUQT09',
      );
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: SiteColor.blue,
          content: Text(
            'Link will be available one hour before the event starts',
            style: SiteFont.primary(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 0,
            ),
          ),
        ),
      );
    }
  }
}

class CountdownWidget extends StatelessWidget {
  const CountdownWidget({
    Key? key,
    required this.number,
    required this.title,
  }) : super(key: key);

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        children: [
          Text(
            number > 9 ? '$number' : '0$number',
            style: TextStyle(
              fontFamily: 'ManoucheSemiExpanded',
              color: SiteColor.blue,
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            number > 1
                ? title
                : title.replaceRange(
                    title.length - 1,
                    title.length,
                    '',
                  ),
            style: SiteFont.primary(
                fontSize: 16.sp,
                letterSpacing: 1.5.sp,
                fontWeight: FontWeight.w500,
                color: SiteColor.darkGrey),
          ),
        ],
      ),
    );
  }
}
