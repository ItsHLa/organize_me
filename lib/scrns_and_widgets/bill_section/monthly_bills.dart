import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/bill_category_spending.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/search_bar_by_month_year.dart';

import 'bills_list.dart';
import 'cubit/bill_cubit.dart';

class MonthlyChart extends StatefulWidget {
  const MonthlyChart({super.key});

  @override
  State<MonthlyChart> createState() => _MonthlyChartState();
}

class _MonthlyChartState extends State<MonthlyChart> {
  List categories = ['الكهرباء', 'الاتصالات', 'المياه'];
  List colors = [green, yellow, blue];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillCubit, BillState>(
      builder: (context, state) {
        print(state.bills.toString());
        if (state is MonthlySpendingCalculated) {
          List monthly = [
            state.monthlySpendingElectricity,
            state.monthlySpendingTelecom,
            state.monthlySpendingWater,
          ];
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
                  PieChartData(
                    centerSpaceRadius: 30,
                    sections: [
                      PieChartSectionData(color: yellow, value: monthly[0]),
                      PieChartSectionData(color: green, value: monthly[1]),
                      PieChartSectionData(color: blue, value: monthly[2]),
                    ],
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 150),
                  // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return BillCategorySpending(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (newcontext) => BlocProvider.value(
                              value: BlocProvider.of<BillCubit>(context),
                              child: BillList(
                                category: categories[index],
                              ),
                            ),
                          ),
                        );
                      },
                      sum: (monthly[index] * state.monthlySpendingAll) / 360,
                      color: colors[index],
                      value: monthly[index],
                      title: categories[index],
                    );
                  },
                ),
              )
            ],
          );
        }
        return const Center(
          child: Text(' لا يوجد فواتير لحساب الاستهلاك الشهري'),
        );
      },
    );
  }
}

/*
*
* const Divider(),
        BillCategorySpending(
          onTap: () async {
            await BlocProvider.of<BillCubit>(context).loadWater();
            if (context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (newcontext) => BlocProvider.value(
                    value: BlocProvider.of<BillCubit>(context),
                    child: const WaterList(),
                  ),
                ),
              );
            }
          },
          sum: 3500,
          color: blue,
          value: 20,
          title: 'المياه',
        ),
        const Divider(),
        BillCategorySpending(
          onTap: () async {
            await BlocProvider.of<BillCubit>(context).loadTelecom();
            if (context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (newcontext) => BlocProvider.value(
                    value: BlocProvider.of<BillCubit>(context),
                    child: const TelecomList(),
                  ),
                ),
              );
            }
          },
          sum: 3500,
          color: green,
          value: 30,
          title: 'الاتصالات',
        )
*
*
* */