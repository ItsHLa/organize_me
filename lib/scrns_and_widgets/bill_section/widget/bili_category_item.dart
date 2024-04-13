import 'package:flutter/material.dart';

class BillItem extends StatelessWidget {
  const BillItem({
    super.key,
    this.onTap,
    required this.billTitle,
  });

  final String billTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(shape: const StadiumBorder(), label: Text(billTitle)),
    );
  }
}
