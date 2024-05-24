import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/bill_category_spending.dart';
import 'package:organize_me/scrns_and_widgets/no_content.dart';

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
  List icons = [electricBill, telecomBill, waterBill];

  @override
  void initState() {
    BlocProvider.of<BillCubit>(context).monthlySpendingOneCategory(
      '2024',
      '01',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillCubit, BillState>(
      buildWhen: (previous, current) =>
          current is MonthlySpendingCalculated || current is BillInitial,
      builder: (context, state) {
        if (state is MonthlySpendingCalculated) {
          List monthlyPercent = state.percent;
          List monthly = state.sum;
          return state.monthlySpendingAll == 0
              ? const Center(
                  child:
                      NoContent(text: 'لا يوجد فواتير لحساب الاستهلاك الشهري '),
                )
              : SizedBox(
                  height: 400,
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
                                  color: yellow, value: monthlyPercent[0]),
                              PieChartSectionData(
                                  color: green, value: monthlyPercent[1]),
                              PieChartSectionData(
                                  color: blue, value: monthlyPercent[2]),
                            ],
                          ),
                          swapAnimationDuration:
                              const Duration(milliseconds: 150),
                          // Optional
                          swapAnimationCurve: Curves.linear, // Optional
                        ),
                      ),
                      CategoriesListView(
                        monthly: monthly,
                        categories: categories,
                        icons: icons,
                      )
                    ],
                  ),
                );
        }
        return Container();
      },
    );
  }
}

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
    required this.categories,
    required this.monthly,
    required this.icons,
  });

  final List categories;
  final List monthly;
  final List icons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            title: categories[index],
            trailing: icons[index],
          );
        },
      ),
    );
  }
}
