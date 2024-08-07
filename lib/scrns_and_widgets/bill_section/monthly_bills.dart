import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/bill_category_spending.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/search_bar_by_month_year.dart';
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

  TextStyle pieChartTitleStyle = const TextStyle(
    color: Colors.black,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BillCubit>(context).monthlySpendingOneCategory(
      lastYear,
      lastMonth,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const MySearchBar(),
        BlocBuilder<BillCubit, BillState>(
          buildWhen: (previous, current) =>
              current is MonthlySpendingCalculated,
          builder: (context, state) {
            if (state is MonthlySpendingCalculated) {
              List monthlyPercent = state.percent;
              List monthly = state.sum;
              return state.monthlySpendingAll == 0
                  ? const Expanded(
                      child: NoContent(
                        text: 'لا يوجد فواتير لهذا الشهر',
                      ),
                    )
                  : Expanded(
                      child: SizedBox(
                        height: 400,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 25),
                              height: 100,
                              width: 170,
                              child: PieChart(
                                PieChartData(
                                  centerSpaceRadius: 30,
                                  sections: [
                                    PieChartSectionData(
                                      title: "${monthlyPercent[0].toInt()}%",
                                      showTitle: true,
                                      color: yellow,
                                      value: monthlyPercent[0],
                                      titleStyle: pieChartTitleStyle,
                                    ),
                                    PieChartSectionData(
                                      title: "${monthlyPercent[1].toInt()}%",
                                      showTitle: true,
                                      color: green,
                                      value: monthlyPercent[1],
                                      titleStyle: pieChartTitleStyle,
                                    ),
                                    PieChartSectionData(
                                      title: "${monthlyPercent[2].toInt()}%",
                                      showTitle: true,
                                      color: blue,
                                      value: monthlyPercent[2],
                                      titleStyle: pieChartTitleStyle,
                                    ),
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
                      ),
                    );
            }
            return Container();
          },
        ),
      ],
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
