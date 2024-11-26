import 'package:bouncy_bargain/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import 'circular_container.dart';

class XPrimaryHeaderContainer extends StatelessWidget {
  const XPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return XCurvedEdgeWidget(
      child: Container(
        color: XColors.primary,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: XCircularContainer(
                backgroundColor: XColors.textWhite.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: XCircularContainer(
                backgroundColor: XColors.textWhite.withOpacity(0.1),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
