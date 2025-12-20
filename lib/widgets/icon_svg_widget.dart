import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:justdrink/constants.dart';

class IconSvgWidget extends StatelessWidget {
  const IconSvgWidget({
    super.key,
    this.padding = 18,
    required this.icon,
    this.color = kOrange,
  });

  final double padding;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SvgPicture.asset('assets/icons/$icon.svg',
          colorFilter: ColorFilter.mode(
              color.withValues(alpha: 0.8),
              BlendMode.srcIn)
      ),
    );
  }
}