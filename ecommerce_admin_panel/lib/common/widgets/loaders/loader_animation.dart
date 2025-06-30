import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/image_strings.dart';

/// A circular loader widget with customizable foreground and background colors.
class TLoaderAnimation extends StatelessWidget {
  final String? animation;

  const TLoaderAnimation({
    super.key,
    this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(animation ?? TImages.defaultLoaderAnimation,
            height: 200, width: 200));
  }
}
