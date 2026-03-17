import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import 'splash.controller.dart';

class SplashView extends StatelessWidget {
  final SplashController controller;
  const SplashView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Fx.scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFF0D0D2B), // Deep premium dark blue
      body: Fx.center(
        child: TweenAnimationBuilder(
           tween: Tween<double>(begin: 0.0, end: 1.0),
           duration: const Duration(milliseconds: 1500),
           curve: Curves.easeOutBack,
           builder: (context, value, child) {
             return Transform.scale(
               scale: 0.5 + (value * 0.5),
               child: Opacity(
                 opacity: value.clamp(0.0, 1.0),
                 child: child,
               )
             );
           },
           child: Fx.col(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               // Icon / Logo
               Fx.box()
                 .w(100).h(100)
                 .bg(Colors.blueAccent)
                 .rounded(30)
                 .shadowMedium()
                 .center()
                 .child(const Icon(Icons.shopping_bag_rounded, size: 50, color: Colors.white)),
               
               Fx.gap(24),
               
               // Brand Name
               Fx.text('FLUXY')
                 .font.xl4()
                 .bold()
                 .tw('tracking-widest')
                 .color(Colors.white),
                 
               Fx.gap(8),
               
               // Subtitle
               Fx.text('PREMIUM COMMERCE')
                 .font.sm()
                 .tw('tracking-[0.2em] opacity-70')
                 .color(Colors.white),
             ],
           ),
        ),
      ),
    );
  }
}
