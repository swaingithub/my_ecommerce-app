import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';

class ShippingAddressView extends StatelessWidget {
  const ShippingAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Fx.scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: Fx.appBar(
        title: 'Shipping Addresses',
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Fx.col(
        alignItems: CrossAxisAlignment.start,
        children: [
          _buildAddressCard('Home', '123 Fluxy Street, San Francisco, CA 94105', true),
          Fx.gap(16),
          _buildAddressCard('Work', '456 Tech Avenue, San Jose, CA 95113', false),
          Fx.gap(32),

          Fx.box()
            .wFull().py(18)
            .bg.transparent
            .border(color: Colors.black87, width: 2)
            .rounded(16)
            .pointer()
            .center()
            .child(Fx.text('+ Add New Address').font.lg().bold().color(Colors.black87))
            .onTap(() {}),
        ],
      ).p(24).scrollable(),
    );
  }

  Widget _buildAddressCard(String title, String address, bool isDefault) {
    return Fx.col(
      alignItems: CrossAxisAlignment.start,
      children: [
        Fx.row(
          justify: MainAxisAlignment.spaceBetween,
          children: [
            Fx.text(title).font.lg().bold().color(Colors.black87).expanded(),
            if (isDefault)
              Fx.box().bg(Colors.green.shade100).rounded(8).px(8).py(4).child(
                Fx.text('Default').font.xs().bold().color(Colors.green.shade800)
              ),
          ],
        ).pb(8),
        Fx.text(address).font.md().muted().pb(16),
        Fx.row(
          children: [
            Fx.text('Edit').font.sm().bold().color(Colors.blueAccent).pointer().onTap((){}),
            Fx.gap(16),
            Fx.text('Delete').font.sm().bold().color(Colors.redAccent).pointer().onTap((){}),
          ],
        )
      ],
    ).p(16).bg.white.rounded(16).shadowSmall().wFull();
  }
}
