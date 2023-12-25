import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconSvgWidget extends StatelessWidget {
  const IconSvgWidget({
    super.key,
    this.padding = 18,
    required this.icon,
    this.color = const Color(0xff988e8d),
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
              color.withOpacity(0.7),
              BlendMode.srcIn)
      ),
    );
  }
}