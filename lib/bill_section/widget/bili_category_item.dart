import 'package:flutter/material.dart';

class BillItem extends StatelessWidget {
  const BillItem({
    super.key,
    required this.iconBill,
    required this.billTitle,
    required this.iconColor,
    this.logic,
  });

  final IconData iconBill;
  final String billTitle;
  final Color iconColor;
  final void Function()? logic;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton.icon(
        onPressed: logic,
        icon: Icon(
          iconBill,
          color: iconColor,
        ),
        label: Text(billTitle),
      ),
    );
  }
}
