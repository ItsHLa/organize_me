import 'package:flutter/material.dart';

class BillCategorySpending extends StatelessWidget {
  const BillCategorySpending(
      {super.key,
      required this.title,
      required this.sum,
      required this.onTap,
      required this.trailing});

  final Widget trailing;
  final String title;
  final double sum;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.arrow_back_ios_new),
      onTap: onTap,
      title: Text(
        title,
        textAlign: TextAlign.right,
      ),
      subtitle: Text(' مجموع فواتيرك : $sum', textAlign: TextAlign.right),
      trailing: trailing,
    );
  }
}
