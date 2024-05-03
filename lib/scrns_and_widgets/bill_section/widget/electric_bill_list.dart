import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

import '../cubit/bill_cubit.dart';
import 'electric_bill_item.dart';

class ElectricList extends StatelessWidget {
  const ElectricList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BillCubit, BillState>(
        builder: (context, state) {
          if (state is LoadingBill) {
            return const CircularProgressIndicator();
          } else if (state is BillLoaded && state.bills.isNotEmpty) {
            return MyListView(
              dataList: state.bills,
              itemCount: state.bills.length,
              itemBuilder: (context, index) {
                ElectricBills current = state.bills[index] as ElectricBills;
                return ElectricBills(
                  date: current.date,
                  operationNumber: current.operationNumber,
                  billingNumber: current.billingNumber,
                  paymentAmount: current.paymentAmount,
                  subscriptionNumber: current.subscriptionNumber,
                );
              },
            );
          }
          return noBillsToShow;
        },
      ),
    );
  }
}
