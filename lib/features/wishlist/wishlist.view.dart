import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../features/home/home.controller.dart';

class WishlistView extends StatelessWidget {
  final HomeController controller;
  final Widget Function(Product, HomeController) buildProductCard;

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
              return Fx.text('Your wishlist is empty.').tw('text-lg text-center py-10').color(controller.textMuted).center();
            }
            return FxGrid(
              columns: crossAxisCount,
              gap: 24,
              childAspectRatio: 0.62,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: wishlistProducts.map((p) => buildProductCard(p, controller)).toList(),
            ).tw('px-6 pb-4').scrollable();
          });
        }
      ),
    ));
  }
}
