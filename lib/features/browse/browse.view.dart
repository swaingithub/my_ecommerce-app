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
                gap: 16,
                childAspectRatio: 1.5,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: controller.categories.where((c) => c != 'All').map((c) {
                  return Fx.box()
                    .tw('rounded-2xl shadow-sm flex items-center justify-center')
                    .bg(controller.surface)
                    .pointer()
                    .child(Fx.text(c).tw('text-xl font-bold').color(controller.text))
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
