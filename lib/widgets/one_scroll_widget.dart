import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justdrink/constants.dart';

class OneScrollWidget extends StatelessWidget {
  const OneScrollWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(25)),
          border: Border.all(color: kOrange, width: 0.5),
          boxShadow: const [
            BoxShadow(
                color: kWhite,
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 0)),
          ],
        gradient: const LinearGradient(
            colors: [
              kWhite,
              kGrey,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.75]),
      ),
      child: Center(child: Text('$index',
        style: kOrangeStyle.copyWith(fontSize: 18.sp),)),
    );
  }
}