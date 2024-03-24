import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const  SimpleDialog(
      contentPadding: EdgeInsets.all(20),
      children:  [
        PaymentButton(name: 'دفع فاتورة المياة', color:water ),
        PaymentButton(name: 'دفع فاتورة الغاز', color: gas),
        PaymentButton(name: 'دفع فاتورة الاتصالات', color: calls),
        PaymentButton(name: 'دفع فاتورة البنزين', color: gasStation)
      ],
    );
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key, required this.name, required this.color});

  final String name;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color
      ),
        onPressed: null ,
      child: Text(name) ,
    );
  }
}

