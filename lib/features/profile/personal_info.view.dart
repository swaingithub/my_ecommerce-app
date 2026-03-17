import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../features/home/home.controller.dart';

class PersonalInfoView extends StatelessWidget {
  final HomeController controller;
  const PersonalInfoView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Fx(() {
      final isDark = controller.isDarkMode.value;
      
      return Fx.scaffold(
        backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey.shade50,
        appBar: Fx.appBar(
          title: 'Personal Info',
          backgroundColor: Colors.transparent,
          foregroundColor: controller.text,
          elevation: 0,
          centerTitle: false,
        ),
      body: Fx.col(
        alignItems: CrossAxisAlignment.start,
        children: [
          // Profile Avatar
          SizedBox(
            width: 104,
            height: 104,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Fx.image(
                  controller.userAvatar.value,
                  width: 104,
                  height: 104,
                  fit: BoxFit.cover,
                  radius: 52,
                  error: Icon(Icons.person, size: 50, color: controller.textMuted),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blueAccent.withOpacity(0.3), width: 4),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Fx.box()
                    .p(8)
                    .bg(Colors.blueAccent)
                    .circle()
                    .border(color: isDark ? const Color(0xFF121212) : Colors.grey.shade50, width: 3)
                    .child(const Icon(Icons.camera_alt, size: 14, color: Colors.white))
                    .pointer()
                ),
              ]
            )
          ).center().pb(32),

          Fx.text('Name').font.md().bold().color(controller.text).pb(8),
          Fx.input(
            signal: controller.userName,
            placeholder: 'Enter your name',
            icon: Icons.person_outline,
          ).bg(isDark ? const Color(0xFF1E1E1E) : Colors.white)
           .border(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200).shadowSmall().rounded(16).mb(24),
          
          Fx.text('Email').font.md().bold().color(controller.text).pb(8),
          Fx.input(
            signal: controller.userEmail,
            placeholder: 'Enter your email',
            icon: Icons.email_outlined,
          ).bg(isDark ? const Color(0xFF1E1E1E) : Colors.white)
           .border(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200).shadowSmall().rounded(16).mb(32),

          Fx.box()
            .wFull().py(18)
            .bg(Colors.blueAccent)
            .rounded(16)
            .pointer()
            .shadowSmall()
            .center()
            .child(Fx.text('Save Changes').font.lg().bold().color(Colors.white))
            .onTap(() {
              Fluxy.back();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Changes saved successfully!'), backgroundColor: Colors.green)
              );
            }),
        ],
      ).p(24).scrollable(),
      );
    });
  }
}
