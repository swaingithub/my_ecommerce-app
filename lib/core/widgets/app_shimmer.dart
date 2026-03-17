import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';

/// A premium shimmer effect, theme-aware and localized to the app.
class AppShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const AppShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade50;

    return Box(
      style: FxStyle(
        width: width,
        height: height,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        backgroundColor: baseColor,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        child: FxMotion(
          duration: const Duration(milliseconds: 1200),
          repeat: true,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  baseColor.withOpacity(0.0),
                  highlightColor.withOpacity(0.6),
                  baseColor.withOpacity(0.0),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ).animate(
          slide: const Offset(1.5, 0),
          duration: 1.5.s,
          repeat: true,
        ),
      ),
    );
  }
}
