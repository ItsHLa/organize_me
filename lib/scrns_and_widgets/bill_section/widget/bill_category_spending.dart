import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BillCategorySpending extends StatelessWidget {
  const BillCategorySpending(
      {super.key,
      required this.color,
      required this.value,
      required this.title,
      required this.sum,
      required this.onTap});

  final Color color;
  final double value;
  final String title;
  final double sum;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      subtitle: Text(' مجموع فواتيرك : $sum'),
      leading: SizedBox(
        height: 35,
        width: 35,
        child: PieChart(
          PieChartData(sections: [
            PieChartSectionData(
              color: color,
              value: value,
            ),
          ]),
          swapAnimationDuration: const Duration(milliseconds: 150), // Optional
          swapAnimationCurve: Curves.linear,
        ),
      ),
    );
  }
}
