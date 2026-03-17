import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../features/home/home.controller.dart';
import 'personal_info.view.dart';
import 'shipping_address.view.dart';
import 'payment_method.view.dart';

class ProfileView extends StatelessWidget {
  final HomeController controller;
  const ProfileView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Fx.scaffold(
      backgroundColor: Colors.transparent,
      appBar: Fx.appBar(
        title: 'Profile',
        backgroundColor: Colors.transparent,
        foregroundColor: controller.text,
        elevation: 0,
        centerTitle: false,
      ),
      body: Builder(
        builder: (context) {
          return Fx.col(
            children: [
              // Profile Header
              Fx(() => Fx.col(
          alignItems: CrossAxisAlignment.center,
          children: [
            Fx.stack(
              children: [
                Fx.image(
                  controller.userAvatar.value,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  radius: 50,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Fx.box()
                    .w(32).h(32)
                    .bg.black
                    .circle()
                    .border(color: Colors.white, width: 3)
                    .center()
                    .pointer()
                    .child(const Icon(Icons.edit, color: Colors.white, size: 16)),
                ),
              ],
            ).tw('mb-4'),
            Fx.text(controller.userName.value).font.xl2().bold().color(controller.text),
            Fx.text(controller.userEmail.value).font.md().muted(),
          ],
        )).tw('w-full pt-8 pb-6'),

        // Quick Stats
        Fx(() => Fx.row(
          children: [
            _buildStatCard('Orders', '${controller.ordersCount.value}').expanded(),
            Fx.gap(12),
            _buildStatCard('Wishlist', '${controller.wishlist.value.length}').expanded(),
            Fx.gap(12),
            _buildStatCard('Points', '${controller.points.value}').expanded(),
          ],
        ).px(24).pb(32)),

        // Settings Groups
        Fx.col(
          alignItems: CrossAxisAlignment.start,
          children: [
            Fx.text('Account Settings'.toUpperCase()).font.xs().bold().color(Colors.grey.shade500).px(24).pb(8),
            Fx.col(
              children: [
                _buildGroupTile(Icons.person_outline, 'Personal Information', 
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PersonalInfoView(controller: controller)))),
                _buildDivider(),
                _buildGroupTile(Icons.location_on_outlined, 'Shipping Addresses', 
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShippingAddressView()))),
                _buildDivider(),
                _buildGroupTile(Icons.payment_outlined, 'Payment Methods', 
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentMethodView()))),
              ],
            ).bg(controller.surface).rounded(20).shadowSmall().mx(24).mb(24),

            Fx.text('Preferences'.toUpperCase()).font.xs().bold().color(Colors.grey.shade500).px(24).pb(8),
            Fx(() => Fx.col(
              children: [
                _buildGroupTile(Icons.notifications_outlined, 'Notifications', 
                  switchValue: controller.notificationsEnabled.value, 
                  onSwitchChanged: (v) => controller.notificationsEnabled.value = v),
                _buildDivider(),
                _buildGroupTile(Icons.language_outlined, 'Language', onTap: () {}, trailingText: controller.language.value),
                _buildDivider(),
                _buildGroupTile(Icons.dark_mode_outlined, 'Dark Mode', 
                  switchValue: controller.isDarkMode.value, 
                  onSwitchChanged: (v) {
                    controller.isDarkMode.value = v;
                    Fx.setThemeMode(v ? ThemeMode.dark : ThemeMode.light);
                  }),
              ],
            )).bg(controller.surface).rounded(20).shadowSmall().mx(24).mb(32),

            // Logout Button (Mixed Tailwind & DSL)
            Fx.box()
              .tw('w-full py-4 rounded-xl shadow-md')
              .bg(controller.surface)
              .pointer()
              .center()
              .child(Fx.text('Log Out').tw('text-lg font-bold').color(Colors.redAccent))
              .onTap(() {})
              .tw('mx-6 mb-10'),
          ],
        ),
      ],
    ).scrollable();
      }),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Fx.col(
      alignItems: CrossAxisAlignment.center,
      children: [
        Fx.text(value).tw('text-2xl font-bold').color(controller.text),
        Fx.gap(4),
        Fx.text(title).tw('text-sm').color(controller.textMuted),
      ],
    ).tw('p-4 rounded-xl shadow-md').bg(controller.surface);
  }

  Widget _buildGroupTile(IconData icon, String title, {VoidCallback? onTap, String? trailingText, bool? switchValue, ValueChanged<bool>? onSwitchChanged}) {
    return Fx.row(
      children: [
        Fx.box()
          .tw('p-2.5 rounded-xl')
          .bg(controller.isDarkMode.value ? Colors.grey.shade800 : Colors.grey.shade100)
          .child(Icon(icon, color: controller.text, size: 20)),
        Fx.gap(16),
        Fx.text(title).tw('text-lg font-medium').color(controller.text).expanded(),
        if (trailingText != null) Fx.text(trailingText).tw('text-base pr-2').color(controller.textMuted),
        if (switchValue != null) 
          Switch(value: switchValue, onChanged: onSwitchChanged, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)
        else
          Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 24),
      ],
    ).tw('px-4 py-3 pointer').onTap(() => onTap?.call());
  }

  Widget _buildDivider() {
    return Fx.box().tw('w-full mx-4').h(1).bg(controller.isDarkMode.value ? Colors.grey.shade800 : Colors.grey.shade100);
  }
}
