import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../core/widgets/app_shimmer.dart';
import 'auth.controller.dart';

class AuthView extends StatelessWidget {
  final AuthController controller;
  
  const AuthView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Fx(() {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final isSignUp = controller.isSignUpMode.value;
      final loading = controller.isLoading.value;

      return Fx.scaffold(
        backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8FAFC),
        body: Fx.safeArea(
          child: Fx.col(
            alignItems: CrossAxisAlignment.start,
            children: [
              // Header
              Fx.col(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Fx.box()
                    .w(60).h(60)
                    .bg(Colors.blueAccent)
                    .rounded(20)
                    .shadowMedium()
                    .center()
                    .child(const Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 30))
                    .mb(32),

                  Fx.text(isSignUp ? 'Create Account' : 'Welcome Back')
                    .font.xl4()
                    .bold()
                    .color(isDark ? Colors.white : const Color(0xFF0F172A)),
                    
                  Fx.gap(8),
                  
                  Fx.text(isSignUp ? 'Sign up to discover premium products.' : 'Sign in to access your premium account.')
                    .font.md()
                    .tw('opacity-70')
                    .color(isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                ]
              ).wFull().px(24).pt(40).pb(20),

              // Form
              Fx.col(
                children: [
                  if (isSignUp) ...[
                    Fx.input(
                      signal: controller.fullName,
                      placeholder: 'Full Name',
                      icon: Icons.person_outline,
                    ).bg(isDark ? const Color(0xFF1E1E1E) : Colors.white)
                     .border(color: isDark ? Colors.white12 : Colors.grey.shade200, width: 1.5)
                     .rounded(20)
                     .mb(20)
                     .py(20),
                  ],

                  Fx.input(
                    signal: controller.email,
                    placeholder: 'Email Address',
                    icon: Icons.email_outlined,
                  ).bg(isDark ? const Color(0xFF1E1E1E) : Colors.white)
                   .border(color: isDark ? Colors.white12 : Colors.grey.shade200, width: 1.5)
                   .rounded(20)
                   .mb(20)
                   .py(20),

                  Fx.input(
                    signal: controller.password,
                    placeholder: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ).bg(isDark ? const Color(0xFF1E1E1E) : Colors.white)
                   .border(color: isDark ? Colors.white12 : Colors.grey.shade200, width: 1.5)
                   .rounded(20)
                   .mb(8)
                   .py(20),

                  if (!isSignUp)
                    Fx.row(
                      justify: MainAxisAlignment.end,
                      children: [
                        Fx.text('Forgot Password?')
                          .font.sm()
                          .bold()
                          .color(Colors.blueAccent)
                          .pointer()
                          .onTap(() {})
                      ]
                    ).mb(32)
                  else
                    Fx.gap(32),

                  // Auth Button
                  if (loading)
                    const AppShimmer(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ).wFull().h(68)
                  else
                    Fx.box()
                      .wFull()
                      .py(20)
                      .rounded(24)
                      .shadowMedium()
                      .pointer()
                      .bg(const Color(0xFF0D0D2B))
                      .center()
                      .child(
                        Fx.text(isSignUp ? 'Sign Up' : 'Sign In').font.xl().bold().color(Colors.white)
                      )
                      .onTap(() => controller.handleAuth(context)),

                  Fx.gap(24),

                  // Divider
                  Fx.row(
                    children: [
                      Fx.box().h(1).bg(isDark ? Colors.white12 : Colors.grey.shade300).expanded(),
                      Fx.text(' OR ').font.sm().bold().color(Colors.grey.shade500).px(12),
                      Fx.box().h(1).bg(isDark ? Colors.white12 : Colors.grey.shade300).expanded(),
                    ]
                  ).mb(24),

                  // OAuth Buttons
                  Fx.row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(Icons.g_mobiledata_rounded, Colors.redAccent, isDark),
                      Fx.gap(16),
                      _buildSocialButton(Icons.apple, isDark ? Colors.white : Colors.black, isDark),
                      Fx.gap(16),
                      _buildSocialButton(Icons.facebook, Colors.blue, isDark),
                    ]
                  ).mb(32),

                  // Toggle mode
                  Fx.row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Fx.text(isSignUp ? 'Already have an account? ' : 'Don\'t have an account? ')
                        .font.md()
                        .color(isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                      Fx.text(isSignUp ? 'Sign In' : 'Sign Up')
                        .font.md()
                        .bold()
                        .color(Colors.blueAccent)
                        .pointer()
                        .onTap(controller.toggleMode),
                    ]
                  )
                ],
              ).px(24).scrollable().expanded(),
            ],
          ).hFull(),
        ),
      );
    });
  }

  Widget _buildSocialButton(IconData icon, Color color, bool isDark) {
    return Fx.box()
      .w(64).h(64)
      .rounded(20)
      .bg(isDark ? const Color(0xFF1E1E1E) : Colors.white)
      .border(color: isDark ? Colors.white12 : Colors.grey.shade200, width: 1.5)
      .shadowSmall()
      .center()
      .pointer()
      .child(Icon(icon, color: color, size: 36))
      .onTap(() {});
  }
}
