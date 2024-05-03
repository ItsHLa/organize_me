import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/bill_category_spending.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/electric_bill_list.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/search_bar_by_month_year.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/telecom_list.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/water_list.dart';

import 'cubit/bill_cubit.dart';

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
        BillCategorySpending(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (newcontext) => BlocProvider.value(
                      value: BlocProvider.of<BillCubit>(context),
                      child: const ElectricList())));
            },
            sum: 3500,
            color: yellow,
            value: 50,
            title: 'الكهرباء'),
        const Divider(),
        BillCategorySpending(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (newcontext) => BlocProvider.value(
                      value: BlocProvider.of<BillCubit>(context),
                      child: const WaterList())));
            },
            sum: 3500,
            color: blue,
            value: 20,
            title: 'المياه'),
        const Divider(),
        BillCategorySpending(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (newcontext) => BlocProvider.value(
                      value: BlocProvider.of<BillCubit>(context),
                      child: const TelecomList())));
            },
            sum: 3500,
            color: green,
            value: 30,
            title: 'الاتصالات')
      ],
    );
  }
}


