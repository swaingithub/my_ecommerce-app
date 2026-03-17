import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../features/home/home.controller.dart';

class WishlistView extends StatelessWidget {
  final HomeController controller;
  final Widget Function(BuildContext, Product, HomeController) buildProductCard;

  const WishlistView({
    super.key, 
    required this.controller,
    required this.buildProductCard,
  });

  @override
  Widget build(BuildContext context) {
    var crossAxisCount = MediaQuery.of(context).size.width > 800 ? 4 : 2;
    return Fx(() => Fx.scaffold(
      backgroundColor: Colors.transparent,
      appBar: Fx.appBar(
        title: 'My Wishlist',
        backgroundColor: Colors.transparent,
        foregroundColor: controller.text,
        elevation: 0,
        centerTitle: false,
      ),
      body: Builder(
        builder: (context) {
          return Fx(() {
            var wishlistProducts = controller.products.value.where((p) => controller.wishlist.value.contains(p.id)).toList();
            if (wishlistProducts.isEmpty) {
              return Fx.col(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Fx.box()
                    .w(100).h(100)
                    .bg(controller.isDarkMode.value ? Colors.white12 : Colors.grey.shade100)
                    .circle()
                    .center()
                    .child(Icon(Icons.style_outlined, size: 50, color: controller.textMuted)),
                  Fx.gap(24),
                  Fx.text('Nothing saved yet').font.xl().bold().color(controller.text),
                  Fx.gap(8),
                  Fx.text('Heart your favorite items to create your personal premium collection.').font.sm().color(controller.textMuted).tw('text-center px-12'),
                  Fx.gap(32),
                  Fx.box()
                    .w(200).py(14)
                    .rounded(20)
                    .bg(Colors.blueAccent)
                    .shadowMedium()
                    .center()
                    .pointer()
                    .child(Fx.text('Discover Daily').font.md().bold().color(Colors.white))
                    .onTap(() {
                      controller.changeNavIndex(0); // Assuming 0 is the Home/Discover tab
                    }),
                ],
              ).center().expanded();
            }
            return FxGrid(
              columns: crossAxisCount,
              gap: 24,
              childAspectRatio: 0.62,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: wishlistProducts.map((p) => buildProductCard(context, p, controller)).toList(),
            ).tw('px-6 pb-4').scrollable();
          });
        }
      ),
    ));
  }
}
