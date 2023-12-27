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
    backgroundColor: kBlue.withOpacity(0.8),
    dialHandColor: kOrange.withOpacity(0.6),
    elevation: 10,
    dialTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected) ? kWhite : kWhite),
    hourMinuteColor: MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.selected) ? kBlue : kBlue.withOpacity(0.5)),
    hourMinuteTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected) ? kWhite : kWhite.withOpacity(0.8)),
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
      foregroundColor: MaterialStateColor.resolveWith((states) => kOrange),
      backgroundColor: MaterialStateColor.resolveWith((states) => kBlue),
    ),
  ),
);

