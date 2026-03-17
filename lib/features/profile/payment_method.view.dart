import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';

import '../../features/home/home.controller.dart';

class PaymentMethodView extends StatelessWidget {
  final HomeController controller;
  const PaymentMethodView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Fx(() => Fx.scaffold(
      backgroundColor: controller.surface,
      appBar: Fx.appBar(
        title: 'Payment Methods',
        backgroundColor: Colors.transparent,
        foregroundColor: controller.text,
        elevation: 0,
      ),
      body: Fx.col(
        alignItems: CrossAxisAlignment.start,
        children: [
          ...controller.paymentCards.value.map((payment) {
            final isSelected = controller.selectedPaymentId.value == payment.id;
            return _buildCardInfo(payment, isSelected).mb(20);
          }),
          Fx.gap(16),
          Fx.box()
            .wFull().py(18)
            .bg.transparent
            .border(color: controller.text, width: 2)
            .rounded(16)
            .pointer()
            .center()
            .child(Fx.text('+ Add Payment Method').font.lg().bold().color(controller.text))
            .onTap(() {
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add Card UI placeholder.')));
            }),
        ],
      ).p(24).scrollable(),
    ));
  }

  Widget _buildCardInfo(PaymentCard card, bool isSelected) {
    return Fx.col(
      alignItems: CrossAxisAlignment.start,
      children: [
        Fx.row(
          justify: MainAxisAlignment.spaceBetween,
          children: [
            Fx.row(
              children: [
                Icon(card.iconType == 'visa' ? Icons.credit_card : Icons.credit_card_outlined, color: controller.text),
                Fx.gap(12),
                Fx.text(card.bank).font.lg().bold().color(controller.text),
              ],
            ).expanded(),
            Fx.box().bg(isSelected ? Colors.blueAccent : Colors.transparent).rounded(8).px(12).py(6).border(color: isSelected ? Colors.transparent : controller.textMuted).pointer().onTap((){
               controller.selectedPaymentId.value = card.id;
               Fluxy.back();
            }).child(
              Fx.text(isSelected ? 'Selected' : 'Select').font.xs().bold().color(isSelected ? Colors.white : controller.textMuted)
            ),
          ],
        ).pb(12),
        Fx.text('**** **** **** ${card.last4}').font.xl().medium().color(controller.text).pb(4),
        Fx.text('Expires 12/26').font.sm().color(controller.textMuted),
      ],
    ).p(20).bg(isSelected ? Colors.blueAccent.withOpacity(0.05) : controller.surface).rounded(16).border(color: isSelected ? Colors.blueAccent : (controller.isDarkMode.value ? Colors.white12 : Colors.grey.shade200), width: isSelected ? 2 : 1).wFull().pointer().onTap((){
       controller.selectedPaymentId.value = card.id;
    });
  }
}
