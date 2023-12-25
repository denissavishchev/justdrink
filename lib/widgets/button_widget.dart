import 'package:flutter/material.dart';
import 'package:justdrink/constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key,
    required this.child,
    required this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: kGrey.withOpacity(0.8),
                    spreadRadius: 4,
                    blurRadius: 12,
                    offset: const Offset(4, 4)
                  )
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.grey.withOpacity(0.8),
                  ],
                ),
              ),
              child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey,
                          Colors.white,
                        ],
                      ),
                    ),
                    child: Center(
                        child: child),
                  )
              ),
            )
        ),
      ),
    );
  }
}
