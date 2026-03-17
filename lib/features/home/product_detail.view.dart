import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import 'home.controller.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;
  final HomeController controller;

  const ProductDetailView({
    super.key,
    required this.product,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Fx(() {
      final isWishlisted = controller.wishlist.value.contains(product.id);
      return Fx.scaffold(
        backgroundColor: controller.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: controller.text, size: 20),
            onPressed: () => Fluxy.back(),
          ),
          actions: [
            Fx.box()
              .p(8)
              .bg(controller.isDarkMode.value ? Colors.grey.shade800 : Colors.white)
              .circle()
              .shadowSmall()
              .pointer()
              .child(Icon(
                isWishlisted ? Icons.favorite : Icons.favorite_border,
                color: isWishlisted ? Colors.redAccent : (controller.isDarkMode.value ? Colors.grey.shade400 : Colors.black45),
                size: 20,
              ))
              .onTap(() => controller.toggleWishlist(product))
              .pr(16),
          ],
        ),
        body: Fx.col(
          children: [
            // Image Section with Hero
            Hero(
              tag: 'product_image_${product.id}',
              child: Fx.image(
                product.imageUrl,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.45,
                fit: BoxFit.cover,
                error: const Icon(Icons.error).center(),
              ),
            ),
            
            // Details Section
            Fx.col(
              alignItems: CrossAxisAlignment.start,
              children: [
                Fx.row(
                  justify: MainAxisAlignment.spaceBetween,
                  children: [
                    Fx.text(product.category.toUpperCase())
                      .font.sm().bold().color(Colors.blueAccent).tw('tracking-widest'),
                    Fx.row(children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      Fx.gap(4),
                      Fx.text(product.rating.toStringAsFixed(1)).font.md().bold().color(controller.text),
                      Fx.gap(4),
                      Fx.text('(${product.reviews} reviews)').font.sm().color(controller.textMuted),
                    ]),
                  ]
                ),
                Fx.gap(16),
                Fx.text(product.name).font.xl3().bold().color(controller.text),
                Fx.gap(12),
                Fx.text('\$${product.price.toStringAsFixed(2)}')
                  .font.xl2().bold().color(controller.text),
                Fx.gap(32),
                
                Fx.text('Description').font.lg().bold().color(controller.text),
                Fx.gap(12),
                Fx.text(product.description)
                  .font.md().color(controller.textMuted).tw('leading-relaxed'),
                
                Fx.gap(40),
              ],
            ).p(24).bg(controller.surface),
          ],
        ).scrollable(),
        bottomNavigationBar: Fx.safe(
          Fx.row(
            children: [
              Fx.col(
                 alignItems: CrossAxisAlignment.start,
                 size: MainAxisSize.min,
                 children: [
                   Fx.text('Total Price').font.xs().bold().color(controller.textMuted).tw('uppercase tracking-wider'),
                   Fx.gap(4),
                   Fx.text('\$${product.price.toStringAsFixed(2)}').font.xl().bold().color(controller.text),
                 ]
               ).expanded(),
              Fx.gap(16),
              Fx.box()
                .h(56)
                .w(200)
                .bg(Colors.blueAccent)
                .rounded(16)
                .shadowSmall()
                .center()
                .pointer()
                .child(
                  Fx.row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20),
                      Fx.gap(12),
                      Fx.text('Add to Cart').font.lg().bold().color(Colors.white),
                    ],
                  )
                )
                .onTap(() {
                  controller.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} added to cart!'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(16),
                    )
                  );
                }),
            ],
          ).p(24).bg(controller.surface).shadowSmall()
        ),
      );
    });
  }
}
