import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../features/home/home.controller.dart';

class BrowseView extends StatelessWidget {
  final HomeController controller;
  const BrowseView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Fx(() => Fx.scaffold(
      backgroundColor: Colors.transparent,
      appBar: Fx.appBar(
        title: 'Browse',
        backgroundColor: Colors.transparent,
        foregroundColor: controller.text,
        elevation: 0,
        centerTitle: false,
      ),
      body: Builder(
        builder: (context) {
          return Fx.col(
            alignItems: CrossAxisAlignment.start,
            children: [
              Fx.text('All Categories').tw('text-2xl font-bold px-6 py-4').color(controller.text),
              FxGrid(
                columns: 2,
                gap: 20,
                childAspectRatio: 1.1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: controller.categories.where((c) => c != 'All').map((c) {
                  IconData icon;
                  Color color;
                  if (c == 'Fashion') {
                    icon = Icons.checkroom_rounded;
                    color = const Color(0xFFE83A59); // Vibrant Pink/Red
                  } else if (c == 'Electronics') {
                    icon = Icons.devices_rounded;
                    color = const Color(0xFF2B5876); // Deep Tech Blue
                  } else {
                    icon = Icons.sensor_door_rounded;
                    color = const Color(0xFFE67E22); // Warm Home Orange
                  }

                  return Fx.box()
                    .rounded(28)
                    .shadowMedium()
                    .pointer()
                    .clip() // to clip the watermark icon
                    .bg(color)
                    .child(
                      Fx.stack(
                        children: [
                          Positioned(
                            right: -24,
                            bottom: -24,
                            child: Icon(icon, size: 120, color: Colors.white.withOpacity(0.15)),
                          ),
                          Fx.col(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Fx.box().p(12).circle().bg(Colors.white.withOpacity(0.2)).child(Icon(icon, color: Colors.white, size: 28)),
                              const Spacer(),
                              Fx.text(c).font.xl().bold().color(Colors.white),
                              Fx.gap(4),
                              Fx.text('Explore').font.sm().color(Colors.white.withOpacity(0.9)),
                            ],
                          ).p(20).wFull().hFull(),
                        ],
                      ).wFull().hFull()
                    )
                    .onTap(() {
                      controller.selectedCategory.value = c;
                      controller.currentNavIndex.value = 0;
                    });
                }).toList(),
              ).tw('px-6 pb-6'),
            ],
          ).scrollable();
        }
      ),
    ));
  }
}
