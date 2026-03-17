import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';

import '../../features/home/home.controller.dart';

class ShippingAddressView extends StatelessWidget {
  final HomeController controller;
  const ShippingAddressView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Fx(
      () => Fx.scaffold(
        backgroundColor: controller.surface,
      appBar: Fx.appBar(
        title: 'Shipping Addresses',
        backgroundColor: Colors.transparent,
          foregroundColor: controller.text,
        elevation: 0,
      ),
      body: Fx.col(
        alignItems: CrossAxisAlignment.start,
        children: [
            ...controller.addresses.value.map((address) {
              final isSelected =
                  controller.selectedAddressId.value == address.id;
              return _buildAddressCard(address, isSelected).mb(20);
            }),
            Fx.gap(20),

          Fx.box()
            .wFull().py(18)
            .bg.transparent
                .border(color: controller.text, width: 2)
            .rounded(16)
            .pointer()
            .center()
                .child(
                  Fx.text(
                    '+ Add New Address',
                  ).font.lg().bold().color(controller.text),
                )
                .onTap(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add Address UI placeholder.'),
                    ),
                  );
                }),
        ],
      ).p(24).scrollable(),
      ),
    );
  }

  Widget _buildAddressCard(Address address, bool isSelected) {
    return Fx.col(
      alignItems: CrossAxisAlignment.start,
      children: [
        Fx.row(
          justify: MainAxisAlignment.spaceBetween,
          children: [
                Fx.text(
                  address.label,
                ).font.lg().bold().color(controller.text).expanded(),
                if (address.isDefault)
              Fx.box().bg(Colors.green.shade100).rounded(8).px(8).py(4).child(
                Fx.text('Default').font.xs().bold().color(Colors.green.shade800)
              ),
          ],
        ).pb(8),
            Fx.text(
              address.fullAddress,
            ).font.md().color(controller.textMuted).pb(16),
        Fx.row(
          children: [
                Fx.text('Select').font
                    .sm()
                    .bold()
                    .color(isSelected ? Colors.green : Colors.blueAccent)
                    .pointer()
                    .onTap(() {
                      controller.selectedAddressId.value = address.id;
                      Fluxy.back();
                    }),
                Fx.gap(16),
                Fx.text('Edit').font
                    .sm()
                    .bold()
                    .color(controller.textMuted)
                    .pointer()
                    .onTap(() {}),
            Fx.gap(16),
            Fx.text('Delete').font.sm().bold().color(Colors.redAccent).pointer().onTap((){}),
          ],
        )
      ],
        )
        .p(16)
        .bg(
          isSelected ? Colors.blueAccent.withOpacity(0.05) : controller.surface,
        )
        .rounded(16)
        .border(
          color: isSelected
              ? Colors.blueAccent
              : (controller.isDarkMode.value
                    ? Colors.white12
                    : Colors.grey.shade200),
          width: isSelected ? 2 : 1,
        )
        .wFull()
        .pointer()
        .onTap(() {
          controller.selectedAddressId.value = address.id;
        });
  }
}
