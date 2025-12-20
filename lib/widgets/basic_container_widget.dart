import 'package:flutter/material.dart';

import '../constants.dart';

class BasicContainerWidget extends StatelessWidget {
  const BasicContainerWidget({
    super.key,
    required this.height,
    required this.width,
    this.right = true,
    required this.child,
  });

  final double height;
  final double width;
  final bool right;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: kBlue,
          border: Border.all(width: 0.5, color: kOrange),
          boxShadow: [
            BoxShadow(
                color: kGrey.withValues(alpha: 0.8),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(right ? 4 : -4, 4)
            )
          ],
          borderRadius: right
              ? const BorderRadius.horizontal(
              right: Radius.circular(130))
              : const BorderRadius.horizontal(
              left: Radius.circular(130))
      ),
      child: child,
    );
  }
}