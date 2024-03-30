import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleDialog(
      contentPadding: EdgeInsets.all(20),
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'هل تريد دفع فواتيرك الآن ؟',
            textAlign: TextAlign.center,
          ),
        ),
        PaymentButton(
          name: 'دفع من تطبيق أقرب إليك',
          logic: null,
        ),
        PaymentButton(
          name: 'دفع عن طريق سيرياتيل كاش',
          logic: null,
        ),
      ],
    );
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key, required this.name, this.logic});
  final void Function()? logic;
  final String name;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: logic,
      child: Text(name),
    );
  }
}
