import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/payment_widget.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/search_bar_by_month_year.dart';
import 'package:organize_me/scrns_and_widgets/floating_action_button.dart';
import 'package:organize_me/services/work_manager_service.dart';

import 'cubit/bill_cubit.dart';
import 'monthly_bills.dart';

class MyBills extends StatelessWidget {
  const MyBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFab(
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.payments,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const PaymentPage(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("$lastSelectedYear-$lastSelectedMonth"),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (newcontext) => BlocProvider<BillCubit>.value(
                        value: BlocProvider.of(context),
                        child: const MySearchBar(),
                      ),
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.search_circle,
                    color: appColorTheme,
                  ),
                ),
              ],
            ),
            const MonthlyChart(),
          ],
        ),
      ),
    );
  }
}
