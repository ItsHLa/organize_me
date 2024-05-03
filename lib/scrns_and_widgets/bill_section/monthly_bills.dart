import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

import '../date_time_picker.dart';

class MonthlyChart extends StatelessWidget {
  const MonthlyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MySearchBar(),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 170,
          width: 170,
          child: PieChart(
            PieChartData(centerSpaceRadius: 30, sections: [
              PieChartSectionData(color: yellow, value: 50),
              PieChartSectionData(color: blue, value: 20),
              PieChartSectionData(color: green, value: 30),
            ]),
            swapAnimationDuration: const Duration(milliseconds: 150),
            // Optional
            swapAnimationCurve: Curves.linear, // Optional
          ),
        ),
        const BillCategorySpending(
            sum: 3500, color: yellow, value: 50, title: 'الكهرباء'),
        const Divider(),
        const BillCategorySpending(
            sum: 3500, color: blue, value: 20, title: 'المياه'),
        const Divider(),
        const BillCategorySpending(
            sum: 3500, color: green, value: 30, title: 'الاتصالات')
      ],
    );
  }
}

class BillCategorySpending extends StatelessWidget {
  const BillCategorySpending(
      {super.key,
      required this.color,
      required this.value,
      required this.title,
      required this.sum});

  final Color color;
  final double value;
  final String title;
  final double sum;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('مجموع فواتيرك : $sum'),
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

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
          height: 45,
          child: MyDatePicker(
            labelText: '',
            onTap: () {},
            controller: TextEditingController(text: ''),
          )),
    );
  }
}
/*
*
* TextField(

          decoration: InputDecoration(
            border: OutlineInputBorder(
              gapPadding: 8,
              borderRadius: BorderRadius.circular(18)
            ),
            prefixIcon: IconButton(
              onPressed: (){
                print('object');
              },
              icon: Icon(Icons.search),
            )
          ),
        ),
*
* */

/*
*
*  var selected = await showMonthYearPicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2024),
              lastDate: DateTime(3000),
            );
*
* */
