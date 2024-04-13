import 'package:flutter/material.dart';

class BillItem extends StatelessWidget {
  const BillItem({
    super.key,
    this.logic,
    required this.billTitle,
  });

  final String billTitle;
  final void Function()? logic;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Chip(shape: const StadiumBorder(), label: Text(billTitle)),
    );
  }
}
