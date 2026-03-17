import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';

class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Fx.scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: Fx.appBar(
        title: 'Payment Methods',
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Fx.col(
        alignItems: CrossAxisAlignment.start,
        children: [
          _buildCardInfo('Visa', '**** **** **** 4242', '12/25', true),
          Fx.gap(16),
          _buildCardInfo('Mastercard', '**** **** **** 5555', '08/26', false),
          Fx.gap(32),
          Fx.box()
            .wFull().py(18)
            .bg.transparent
            .border(color: Colors.black87, width: 2)
            .rounded(16)
            .pointer()
            .center()
            .child(Fx.text('+ Add Payment Method').font.lg().bold().color(Colors.black87))
            .onTap(() {}),
        ],
      ).p(24).scrollable(),
    );
  }

  Widget _buildCardInfo(String type, String number, String exp, bool isDefault) {
    return Fx.col(
      alignItems: CrossAxisAlignment.start,
      children: [
        Fx.row(
          justify: MainAxisAlignment.spaceBetween,
          children: [
            Fx.row(
              children: [
                const Icon(Icons.credit_card, color: Colors.black87),
                Fx.gap(12),
                Fx.text(type).font.lg().bold().color(Colors.black87),
              ],
            ).expanded(),
            if (isDefault)
              Fx.box().bg(Colors.blue.shade100).rounded(8).px(8).py(4).child(
                Fx.text('Default').font.xs().bold().color(Colors.blue.shade800)
              ),
          ],
        ).pb(12),
        Fx.text(number).font.xl().medium().color(Colors.black87).pb(4),
        Fx.text('Expires $exp').font.sm().muted(),
      ],
    ).p(20).bg.white.rounded(16).shadowSmall().wFull();
  }
}
