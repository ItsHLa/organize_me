import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/bill_category_spending.dart';

import 'bills_list.dart';
import 'cubit/bill_cubit.dart';

class MonthlyChart extends StatefulWidget {
  const MonthlyChart({super.key});

  @override
  State<MonthlyChart> createState() => _MonthlyChartState();
}

class _MonthlyChartState extends State<MonthlyChart> {
  List categories = ['الكهرباء', 'الاتصالات', 'المياه'];
  List colors = [yellow, green, blue];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BillCubit>(context).monthlySpendingOneCategory(
        DateTime.now().year.toString(), DateTime.now().month.toString());
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BillCubit>(context).monthlySpendingOneCategory(
        DateTime.now().year.toString(), DateTime.now().month.toString());
    return BlocBuilder<BillCubit, BillState>(
      builder: (context, state) {
        print(state);
        if (state is MonthlySpendingCalculated) {
          print(state.monthlySpendingAll);
          if (state.monthlySpendingAll == 0) {
            return const Center(
                child: Text('لا يوجد فواتير لحساب الاستهلاك الشهري '));
          } else {
            List monthlyPercent = [
              (state.monthlySpendingElectricity / state.monthlySpendingAll) *
                  360,
              (state.monthlySpendingTelecom / state.monthlySpendingAll) * 360,
              (state.monthlySpendingWater / state.monthlySpendingAll) * 360,
            ];
            List monthly = [
              state.monthlySpendingElectricity,
              state.monthlySpendingTelecom,
              state.monthlySpendingWater,
            ];
            return SizedBox(
              height: 2000,
              child: Column(
                children: [
                  SizedBox(
                    height: 170,
                    width: 170,
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: 30,
                        sections: [
                          PieChartSectionData(
                              color: yellow, value: monthlyPercent[0]), //
                          PieChartSectionData(
                              color: green, value: monthlyPercent[1]), //
                          PieChartSectionData(
                              color: blue, value: monthlyPercent[2]), //
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
                    itemBuilder: (newcontext, index) {
                      return BillCategorySpending(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ncontext) => BlocProvider.value(
                                value: BlocProvider.of<BillCubit>(context),
                                child: BillList(
                                  category: categories[index],
                                ),
                              ),
                            ),
                          );
                        },
                        sum: monthly[index],
                        color: colors[index],
                        value: monthlyPercent[index],
                        title: categories[index],
                      );
                    },
                  ))
                ],
              ),
            );
          }
        }
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}

class Category extends StatelessWidget {
  const Category(
      {super.key,
      required this.categories,
      required this.monthly,
      required this.colors,
      required this.monthlyPercent});

  final List categories;
  final List monthly;
  final List colors;
  final List monthlyPercent;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (newcontext, index) {
        return BillCategorySpending(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ncontext) => BlocProvider.value(
                  value: BlocProvider.of<BillCubit>(context),
                  child: BillList(
                    category: categories[index],
                  ),
                ),
              ),
            );
          },
          sum: monthly[index],
          color: colors[index],
          value: monthlyPercent[index],
          title: categories[index],
        );
      },
    );
  }
}
