import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../core/widgets/app_shimmer.dart';
import 'home.controller.dart';
import '../browse/browse.view.dart';
import '../wishlist/wishlist.view.dart';
import '../profile/profile.view.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Fluxy.find<HomeController>();

    return Fx(() {
      final index = controller.currentNavIndex.value;
      return Fx.scaffold(
        backgroundColor: controller.isDarkMode.value
            ? const Color(0xFF121212)
            : Colors.grey.shade50,
        appBar: index == 0
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 80,
                iconTheme: IconThemeData(color: controller.text),
                title: Fx.col(
                  alignItems: CrossAxisAlignment.start,
                  children: [
                    Fx.text(
                      'Welcome back,',
                    ).font.sm().color(controller.textMuted),
                    Fx.text(
                      'Discover',
                    ).font.xl3().bold().color(controller.text),
                  ],
                ),
                actions: [
                  Fx(
                    () => FxBadge(
                      label: '${controller.cart.value.length}',
                      color: Colors.redAccent,
                      offset: const Offset(4, -4),
                      child: Fx.box()
                          .w(44)
                          .h(44)
                          .bg(controller.surface)
                          .rounded(14)
                          .shadowSmall()
                          .pointer()
                          .center()
                          .child(
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: controller.text,
                            ),
                          )
                          .onTap(() => _openCart(context, controller)),
                    ),
                  ).pr(20).center(),
                ],
              )
            : null,
        body: Builder(
          builder: (context) {
            if (index == 0) return _buildHomeView(context, controller);
            if (index == 1) return BrowseView(controller: controller);
            if (index == 2)
              return WishlistView(
                controller: controller,
                buildProductCard: _buildProductCard,
              );
            return ProfileView(controller: controller);
          },
        ),
        drawer: _buildSidebar(context, controller),
        bottomNavigationBar: Fx(
          () => FxBottomBar(
            currentIndex: controller.currentNavIndex.value,
            onTap: controller.changeNavIndex,
            activeColor: Colors.blueAccent,
            items: const [
              FxBottomBarItem(icon: Icons.home, label: 'Home'),
              FxBottomBarItem(icon: Icons.category, label: 'Browse'),
              FxBottomBarItem(icon: Icons.favorite, label: 'Wishlist'),
              FxBottomBarItem(icon: Icons.person, label: 'Profile'),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSidebar(BuildContext context, HomeController controller) {
    return Drawer(
      backgroundColor: controller.surface,
      surfaceTintColor: Colors.transparent,
      child: Fx.safe(
        Fx.col(
          alignItems: CrossAxisAlignment.start,
          children: [
            // Header Section
            Fx.col(
              alignItems: CrossAxisAlignment.start,
              children: [
                Fx.box()
                    .tw(
                      'w-16 h-16 rounded-full flex items-center justify-center',
                    )
                    .bg(Colors.blueAccent.withOpacity(0.1))
                    .border(color: Colors.blueAccent.withOpacity(0.3), width: 2)
                    .child(
                      const Icon(
                        Icons.person,
                        size: 32,
                        color: Colors.blueAccent,
                      ),
                    ),
                Fx.gap(16),
                Fx.text(
                  'Fluxy User',
                ).tw('text-2xl font-bold').color(controller.text),
                Fx.text(
                  'user@fluxyshop.com',
                ).tw('text-sm').color(controller.textMuted),
              ],
            ).tw('px-8 pt-8 pb-4 w-full'),

            Fx.gap(16),

            // Menu Items
            // Menu Items
            _buildDrawerItem(
              context,
              'Home',
              Icons.home,
              controller,
              navIndex: 0,
            ),
            _buildDrawerItem(
              context,
              'Categories',
              Icons.category_outlined,
              controller,
              navIndex: 1,
            ),
            _buildDrawerItem(
              context,
              'Wishlist',
              Icons.favorite_border,
              controller,
              navIndex: 2,
            ),
            _buildDrawerItem(
              context,
              'Profile',
              Icons.person_outline,
              controller,
              navIndex: 3,
            ),

            Fx.box()
                .tw('w-full my-6 opacity-20')
                .h(1)
                .bg(Colors.grey.shade400)
                .mx(24),

            Fx.text('Account')
                .tw(
                  'text-xs font-bold opacity-50 uppercase tracking-widest px-8 pb-3',
                )
                .color(controller.text),
            _buildDrawerItem(
              context,
              'My Orders',
              Icons.shopping_bag_outlined,
              controller,
              trailing: Fx(() {
                if (controller.ordersCount.value == 0)
                  return const SizedBox.shrink();
                return Fx.box()
                    .bg(Colors.blueAccent)
                    .px(8)
                    .py(2)
                    .rounded(10)
                    .child(
                      Fx.text(
                        '${controller.ordersCount.value}',
                      ).tw('text-xs font-bold text-white'),
                    );
              }),
            ),
            _buildDrawerItem(
              context,
              'Settings',
              Icons.settings_outlined,
              controller,
            ),
            _buildDrawerItem(context, 'Logout', Icons.logout, controller),
          ],
        ).scrollable().pb(40),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon,
    HomeController controller, {
    int? navIndex,
    Widget? trailing,
  }) {
    return Fx(() {
      final isActive =
          navIndex != null && controller.currentNavIndex.value == navIndex;
      return Fx.row(
            children: [
              Icon(
                icon,
                color: isActive ? Colors.blueAccent : controller.textMuted,
                size: 24,
              ),
              Fx.gap(16),
              Fx.text(title)
                  .tw('text-lg font-bold')
                  .color(isActive ? Colors.blueAccent : controller.text)
                  .expanded(),
              if (trailing != null) trailing,
            ],
          )
          .tw('px-6 py-4 mx-6 mb-2 rounded-2xl cursor-pointer')
          .bg(
            isActive ? Colors.blueAccent.withOpacity(0.1) : Colors.transparent,
          )
          .onTap(() {
            if (navIndex != null) controller.changeNavIndex(navIndex);
            Fluxy.back();
          });
    });
  }

  Widget _buildProductCard(
    BuildContext context,
    Product product,
    HomeController controller,
  ) {
    return Fx.col(
          alignItems: CrossAxisAlignment.start,
          children: [
            Fx.stack(
              children: [
                Hero(
                  tag: 'product_image_${product.id}',
                  child: Fx.image(
                    product.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    error: const Icon(Icons.error).center(),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Fx(() {
                    final isWishlisted = controller.wishlist.value.contains(
                      product.id,
                    );
                    return Fx.box()
                        .p(8)
                        .bg(
                          controller.isDarkMode.value
                              ? Colors.grey.shade800
                              : Colors.white,
                        )
                        .circle()
                        .shadowSmall()
                        .pointer()
                        .child(
                          Icon(
                            isWishlisted
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isWishlisted
                                ? Colors.redAccent
                                : (controller.isDarkMode.value
                                      ? Colors.grey.shade400
                                      : Colors.black45),
                            size: 18,
                          ),
                        )
                        .onTap(() => controller.toggleWishlist(product));
                  }),
                ),
              ],
            ).expanded(),
            Fx.col(
              alignItems: CrossAxisAlignment.start,
              children: [
                Fx.text(
                  product.category.toUpperCase(),
                ).font.xs().bold().color(Colors.grey.shade500),
                Fx.gap(4),
                Fx.text(product.name).font.md().bold().color(controller.text),
                Fx.gap(12),
                Fx.row(
                  justify: MainAxisAlignment.spaceBetween,
                  children: [
                    Fx.text(
                      '\$${product.price.toStringAsFixed(2)}',
                    ).font.xl().bold().color(controller.text),
                    Fx.box()
                        .w(36)
                        .h(36)
                        .bg(controller.text)
                        .rounded(10)
                        .pointer()
                        .center()
                        .child(
                          Icon(Icons.add, color: controller.surface, size: 20),
                        )
                        .onTap(() => controller.addToCart(product)),
                  ],
                ).wFull(),
              ],
            ).p(20),
          ],
        )
        .bg(controller.surface)
        .rounded(32)
        .clip()
        .border(
          color: controller.isDarkMode.value
              ? Colors.white10
              : Colors.black.withOpacity(0.04),
          width: 1.5,
        )
        .shadowMedium()
        .pointer()
        .onTap(
          () => Fluxy.to(
            '/product',
            arguments: {'product': product, 'controller': controller},
          ),
        );
  }

  void _openCart(BuildContext context, HomeController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _CartSheet(controller: controller),
    );
  }

  Widget _buildHomeView(BuildContext context, HomeController controller) {
    var crossAxisCount = MediaQuery.of(context).size.width > 800 ? 4 : 2;
    return Fx(() {
      final products = controller.filteredProducts.value;
      return Fx.col(
        children: [
          Fx.col(
            alignItems: CrossAxisAlignment.start,
            children: [
              Fx.input(
                    signal: controller.searchQuery,
                    placeholder: 'Search for anything...',
                    icon: Icons.search,
                  )
                  .bg(
                    controller.isDarkMode.value ? Colors.white10 : Colors.white,
                  )
                  .border(
                    color: controller.isDarkMode.value
                        ? Colors.white12
                        : Colors.grey.shade200,
                    width: 1.5,
                  )
                  .rounded(24),
              Fx.gap(28),
              Fx.text('Categories').font.xl().bold().color(controller.text),
              Fx.gap(12),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return Fx(() {
                      final isSelected =
                          controller.selectedCategory.value == category;
                      return Fx.text(category).font
                          .sm()
                          .color(
                            isSelected
                                ? (controller.isDarkMode.value
                                      ? Colors.black87
                                      : Colors.white)
                                : controller.textMuted,
                          )
                          .bold()
                          .center()
                          .px(24)
                          .py(12)
                          .bg(isSelected ? controller.text : Colors.transparent)
                          .border(
                            color: isSelected
                                ? Colors.transparent
                                : (controller.isDarkMode.value
                                      ? Colors.white12
                                      : Colors.grey.shade300),
                            width: 1.5,
                          )
                          .rounded(24)
                          .pointer()
                          .onTap(
                            () => controller.selectedCategory.value = category,
                          );
                    });
                  },
                ),
              ),
            ],
          ).p(24),
          if (controller.isLoadingProducts.value)
            FxGrid(
              columns: crossAxisCount,
              gap: 24,
              childAspectRatio: 0.62,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                6,
                (index) => const AppShimmer(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ).px(24).pb(24),
          if (!controller.isLoadingProducts.value && products.isEmpty)
            Fx.text('No products found.').font.lg().muted().center().py(40),
          if (!controller.isLoadingProducts.value && products.isNotEmpty)
            FxGrid(
              columns: crossAxisCount,
              gap: 24,
              childAspectRatio: 0.62,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: products
                  .map((p) => _buildProductCard(context, p, controller))
                  .toList(),
            ).px(24).pb(24),
        ],
      ).scrollable();
    });
  }
}

class _CartSheet extends StatelessWidget {
  final HomeController controller;
  const _CartSheet({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Fx.col(
      children: [
        Fx.box()
            .tw('my-3 w-12 h-1.5 rounded-md')
            .bg(
              controller.isDarkMode.value
                  ? Colors.grey.shade800
                  : Colors.grey.shade200,
            ),
        Fx.row(
          justify: MainAxisAlignment.spaceBetween,
          children: [
            Fx.col(
              alignItems: CrossAxisAlignment.start,
              children: [
                Fx.text(
                  'Your Cart',
                ).tw('text-3xl font-bold').color(controller.text),
                Fx(
                  () => Fx.text(
                    '${controller.cart.value.length} items',
                  ).tw('text-base').color(controller.textMuted),
                ),
              ],
            ),
            Fx.box()
                .tw('w-10 h-10 rounded-full flex items-center justify-center')
                .bg(
                  controller.isDarkMode.value
                      ? Colors.grey.shade800
                      : Colors.grey.shade100,
                )
                .pointer()
                .child(Icon(Icons.close, color: controller.textMuted, size: 20))
                .onTap(() => Fluxy.back()),
          ],
        ).tw('px-6 py-4'),

        Fx(() {
          if (controller.cart.value.isEmpty) {
            return Fx.col(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Fx.box()
                    .w(100)
                    .h(100)
                    .bg(
                      controller.isDarkMode.value
                          ? Colors.white12
                          : Colors.grey.shade100,
                    )
                    .circle()
                    .center()
                    .child(
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 50,
                        color: controller.textMuted,
                      ),
                    ),
                Fx.gap(24),
                Fx.text(
                  'Your cart is empty',
                ).font.xl().bold().color(controller.text),
                Fx.gap(8),
                Fx.text(
                  'Looks like you haven\'t added any premium items yet.',
                ).font.sm().color(controller.textMuted).tw('text-center px-12'),
                Fx.gap(32),
                Fx.box()
                    .w(200)
                    .py(14)
                    .rounded(20)
                    .bg(Colors.blueAccent)
                    .shadowMedium()
                    .center()
                    .pointer()
                    .child(
                      Fx.text(
                        'Start Exploring',
                      ).font.md().bold().color(Colors.white),
                    )
                    .onTap(() {
                      Fluxy.back();
                      controller.changeNavIndex(
                        1,
                      ); // Assuming 1 is the Explore/Browse tab
                    }),
              ],
            ).center().expanded();
          }
          return Fx.list(
            itemCount: controller.cart.value.length,
            itemBuilder: (context, index) {
              final item = controller.cart.value[index];
              return Fx.row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Fx.image(
                          item.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          radius: 30,
                          error: const Icon(Icons.error).center(),
                        ),
                      ),
                      Fx.gap(16),
                      Fx.col(
                        alignItems: CrossAxisAlignment.start,
                        children: [
                          Fx.text(
                            item.name,
                          ).tw('font-bold').color(controller.text),
                          Fx.gap(4),
                          Fx.text(
                            '\$${item.price.toStringAsFixed(2)}',
                          ).tw('font-bold text-blue-500'),
                        ],
                      ).expanded(),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => controller.removeFromCart(item),
                      ),
                    ],
                  )
                  .tw('p-3 mb-6 rounded-2xl')
                  .mb(10)
                  .bg(
                    controller.isDarkMode.value
                        ? Colors.grey.shade800
                        : Colors.grey.shade50,
                  )
                  .border(
                    color: controller.isDarkMode.value
                        ? Colors.grey.shade700
                        : Colors.grey.shade200,
                  );
            },
          ).px(24);
        }).expanded(),
        Fx.safe(
          Fx.col(
            size: MainAxisSize.min,
            children: [
              Fx.row(
                justify: MainAxisAlignment.spaceBetween,
                children: [
                  Fx.text(
                    'Total',
                  ).tw('text-2xl font-bold').color(controller.text),
                  Fx(
                    () => Fx.text(
                      '\$${controller.cartTotal.value.toStringAsFixed(2)}',
                    ).tw('text-3xl font-bold text-blue-500'),
                  ),
                ],
              ),
              Fx.gap(20),
              Fx.box()
                  .tw(
                    'w-full py-4.5 rounded-2xl shadow-sm flex items-center justify-center',
                  )
                  .bg(controller.text)
                  .pointer()
                  .child(
                    Fx.text(
                      'Go to Checkout',
                    ).tw('text-lg font-bold').color(controller.surface),
                  )
                  .onTap(() {
                    if (controller.cart.value.isEmpty) return;
                    Fluxy.back(); // Close cart sheet
                    Fluxy.to(
                      '/checkout',
                      arguments: {'controller': controller},
                    );
                  }),
            ],
          ),
        ).tw('p-6 shadow-md').bg(controller.surface),
      ],
    ).bg(controller.surface);
  }
}
