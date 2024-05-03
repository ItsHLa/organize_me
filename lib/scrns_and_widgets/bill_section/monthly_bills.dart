import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/electric_bill_list.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/telecom_list.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/water_list.dart';
import 'package:organize_me/services/functionality.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

import '../date_time_picker.dart';
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

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  DateTime? selectedDate;

  String date = '';
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          SizedBox(
              height: 48,
              width: 290,
              child: Form(
                key: key,
                child: MyDatePicker(
                  labelText: '',
                  validator: (value) {
                    if (selectedDate != null &&
                        (selectedDate!.year > DateTime.now().year)) {
                      return 'لا يمكن السنة المختارة ان تكون اكبر من السنة الحالية';
                    }
                  },
                  onTap: () async {
                    selectedDate =
                        await SimpleMonthYearPicker.showMonthYearPickerDialog(
                      context: context,
                      disableFuture: false,
                      selectionColor: blue,
                      monthTextStyle: const TextStyle(),
                      yearTextStyle: const TextStyle(),
                      titleTextStyle: const TextStyle(fontSize: 20),
                    );
                    setState(() {
                      date = '${selectedDate?.year} / ${selectedDate?.month}';
                    });
                  },
                  controller: TextEditingController(text: date),
                ),
              )),
          IconButton(
              onPressed: () {
                if (ValidateInputData.validateField(key)) {}
              },
              icon: const Icon(Icons.search_outlined))
        ],
      ),
    );
  }
}
