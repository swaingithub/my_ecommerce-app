import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import '../../core/widgets/app_shimmer.dart';
import '../../features/home/home.controller.dart';


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
              Fx(() {
                final address = controller.selectedAddress.value;
                return Fx.row(
                  children: [
                    Fx.box().w(52).h(52).rounded(18).bg(Colors.blueAccent.withOpacity(0.1)).center().child(const Icon(Icons.location_on, color: Colors.blueAccent)),
                    Fx.gap(16),
                    Fx.col(
                      alignItems: CrossAxisAlignment.start,
                      children: [
                        Fx.text(address.label).tw('text-lg font-bold').color(controller.text),
                        Fx.gap(4),
                        Fx.text(address.fullAddress).tw('text-sm').color(controller.textMuted),
                      ]
                    ).expanded(),
                    Icon(Icons.chevron_right, color: controller.textMuted),
                  ]
                );
              }).p(20).mx(24).mb(28).rounded(24).shadowMedium().pointer().bg(controller.surface).onTap(() => Fluxy.to('/shipping')),

          // Payment Method
          Fx.text('Payment Method').tw('text-xs font-bold opacity-50 uppercase tracking-widest px-8 pb-3').color(controller.text),
              Fx(() {
                final payment = controller.selectedPayment.value;
                return Fx.row(
                  children: [
                    Fx.box().w(52).h(52).rounded(18).bg(Colors.purpleAccent.withOpacity(0.1)).center().child(Icon(payment.iconType == 'visa' ? Icons.credit_card : Icons.credit_card_outlined, color: Colors.purpleAccent)),
                    Fx.gap(16),
                    Fx.col(
                      alignItems: CrossAxisAlignment.start,
                      children: [
                        Fx.text(payment.bank).tw('text-lg font-bold').color(controller.text),
                        Fx.gap(4),
                        Fx.text('**** **** **** ${payment.last4}').tw('text-sm').color(controller.textMuted),
                      ]
                    ).expanded(),
                    Icon(Icons.chevron_right, color: controller.textMuted),
                  ]
                );
              }).p(20).mx(24).mb(36).rounded(24).shadowMedium().pointer().bg(controller.surface).onTap(() => Fluxy.to('/payment')),

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
            Fx(() {
              final isProcessing = controller.isProcessingPayment.value;
              if (isProcessing) {
                return const AppShimmer(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ).wFull().h(68).marginX(18);
              } else {
                return Fx.box()
                  .wFull()
                  .py(20)
                  .marginX(18)
                  .rounded(24)
                  .shadowMedium()
                  .pointer()
                  .center()
                  .bg(Colors.black)
                  .child(
                    Fx.text(
                      'Pay \$${(controller.cartTotal.value + 5.0).toStringAsFixed(2)}',
                    ).tw('text-xl font-bold text-white'),
                  )
                  .onTap(() async {
                    if (controller.cart.value.isEmpty || isProcessing) return;

                    // Simulate Stripe/Braintree payment gateway latency
                    controller.isProcessingPayment.value = true;
                    await Future.delayed(const Duration(seconds: 3));
                    controller.isProcessingPayment.value = false;

                    controller.cart.value = [];
                    controller.ordersCount.value += 1;
                
                    if (context.mounted) {
                      Fluxy.back();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Payment Successful! Order placed securely.',
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(20),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                      );
                    }
                  })
                  .tw('mx-6 mb-12 mt-5');
              }
            }),
        ],
      ).scrollable().tw('pt-4'),
    ));
  }
}
