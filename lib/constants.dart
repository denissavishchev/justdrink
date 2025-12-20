import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kGreen = Color(0xff6cb4b8);
const kBlue = Color(0xffbedce3);
const kWhite = Color(0xfff3f3f6);
const kGrey = Color(0xffe3dcd5);
const kOrange = Color(0xffda7015);

final kOrangeStyle = TextStyle(
    color: kOrange,
    fontWeight: FontWeight.bold,
    fontSize: 12.sp,
    fontFamily: 'Roboto');

final pickerTheme = ThemeData(
  timePickerTheme: TimePickerThemeData(
    dialBackgroundColor: kBlue,
    backgroundColor: kBlue.withValues(alpha: 0.8),
    dialHandColor: kOrange.withValues(alpha: 0.6),
    elevation: 10,
    dialTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected) ? kWhite : kWhite),
    hourMinuteColor: WidgetStateColor.resolveWith((states) =>
    states.contains(WidgetState.selected) ? kBlue : kBlue.withValues(alpha: 0.5)),
    hourMinuteTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected) ? kWhite : kWhite.withValues(alpha: 0.8)),
    hourMinuteShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    entryModeIconColor: kOrange,
    helpTextStyle: kOrangeStyle,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateColor.resolveWith((states) => kOrange),
      backgroundColor: WidgetStateColor.resolveWith((states) => kBlue),
    ),
  ),
);

