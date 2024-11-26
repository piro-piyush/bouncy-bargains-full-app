import 'package:bouncy_bargain/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:flutter/material.dart';

class XCurvedEdgeWidget extends StatelessWidget {
  const XCurvedEdgeWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: XCustomEdges(), child: child);
  }
}
