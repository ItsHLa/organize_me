import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(20),
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'هل تريد دفع فواتيرك الآن ؟',
            textAlign: TextAlign.center,
          ),
        ),
        PaymentButton(
          name: 'دفع عن طريق MTN كاش',
          logic: () async {
            Uri mtnCash = Uri(scheme: 'tel', path: '*2030#');
            await launchUrl(mtnCash);
          },
        ),
        PaymentButton(
          name: 'دفع عن طريق Syriatel كاش',
          logic: () async {
            Uri syriatelCash = Uri(scheme: 'tel', path: '*3040#');
            await launchUrl(syriatelCash);
          },
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
      style: ElevatedButton.styleFrom(backgroundColor: softPurple),
      onPressed: logic,
      child: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
