import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../features/home/home.controller.dart';
import '../../features/profile/shipping_address.view.dart';
import '../../features/profile/payment_method.view.dart';

class CheckoutView extends StatelessWidget {
  final HomeController controller;
  
  const CheckoutView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Fx(() => Fx.scaffold(
      backgroundColor: controller.isDarkMode.value ? const Color(0xFF121212) : Colors.grey.shade50,
      appBar: Fx.appBar(
        title: 'Checkout',
        backgroundColor: Colors.transparent,
        foregroundColor: controller.text,
        elevation: 0,
        centerTitle: true,
      ),
      body: Fx.col(
        alignItems: CrossAxisAlignment.start,
        children: [
          // Shipping Address
          Fx.text('Shipping Address').tw('text-xs font-bold opacity-50 uppercase tracking-widest px-8 pb-3').color(controller.text),
          Fx.row(
            children: [
              Fx.box().w(52).h(52).rounded(18).bg(Colors.blueAccent.withOpacity(0.1)).center().child(const Icon(Icons.location_on, color: Colors.blueAccent)),
              Fx.gap(16),
              Fx.col(
                alignItems: CrossAxisAlignment.start,
                children: [
                  Fx.text('Home').tw('text-lg font-bold').color(controller.text),
                  Fx.gap(4),
                  Fx.text('123 Fluxy Street, San Francisco, CA').tw('text-sm').color(controller.textMuted),
                ]
              ).expanded(),
              Icon(Icons.chevron_right, color: controller.textMuted),
            ]
          ).p(20).mx(24).mb(28).rounded(24).shadowMedium().pointer().bg(controller.surface).onTap(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShippingAddressView()))),

          // Payment Method
          Fx.text('Payment Method').tw('text-xs font-bold opacity-50 uppercase tracking-widest px-8 pb-3').color(controller.text),
          Fx.row(
            children: [
              Fx.box().w(52).h(52).rounded(18).bg(Colors.purpleAccent.withOpacity(0.1)).center().child(const Icon(Icons.credit_card, color: Colors.purpleAccent)),
              Fx.gap(16),
              Fx.col(
                alignItems: CrossAxisAlignment.start,
                children: [
                  Fx.text('Visa').tw('text-lg font-bold').color(controller.text),
                  Fx.gap(4),
                  Fx.text('**** **** **** 4242').tw('text-sm').color(controller.textMuted),
                ]
              ).expanded(),
              Icon(Icons.chevron_right, color: controller.textMuted),
            ]
          ).p(20).mx(24).mb(36).rounded(24).shadowMedium().pointer().bg(controller.surface).onTap(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentMethodView()))),

          // Order Summary
          Fx.text('Order Summary').tw('text-xs font-bold opacity-50 uppercase tracking-widest px-8 pb-3').color(controller.text),
          Fx.col(
            children: [
              Fx.row(justify: MainAxisAlignment.spaceBetween, children: [
                Fx.text('Subtotal').tw('text-base').color(controller.textMuted),
                Fx.text('\$${controller.cartTotal.value.toStringAsFixed(2)}').tw('text-base font-bold').color(controller.text),
              ]).tw('mb-4'),
              Fx.row(justify: MainAxisAlignment.spaceBetween, children: [
                Fx.text('Shipping').tw('text-base').color(controller.textMuted),
                Fx.text('\$5.00').tw('text-base font-bold').color(controller.text),
              ]).tw('mb-6'),
              Fx.box().tw('w-full mb-6 opacity-20').h(1).bg(Colors.grey.shade400),
              Fx.row(justify: MainAxisAlignment.spaceBetween, children: [
                Fx.text('Total').tw('text-lg font-bold').color(controller.textMuted),
                Fx.text('\$${(controller.cartTotal.value + 5.0).toStringAsFixed(2)}').tw('text-3xl font-bold text-blue-500'),
              ]),
            ]
          ).p(24).mx(24).mb(40).rounded(24).shadowMedium().bg(controller.surface),

          // Pay Button
          Fx.box()
            .wFull().py(20)
            .rounded(24)
            .shadowMedium()
            .pointer()
            .center()
            .bg(Colors.blueAccent)
            .child(Fx.text('Pay \$${(controller.cartTotal.value + 5.0).toStringAsFixed(2)}').tw('text-xl font-bold text-white'))
            .onTap(() {
              if (controller.cart.value.isEmpty) return;
              controller.cart.value = [];
              controller.ordersCount.value += 1;
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Payment Successful! Order placed.'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
              ));
            })
            .tw('mx-6 mb-12 m-5'),
        ],
      ).scrollable().tw('pt-4'),
    ));
  }
}
