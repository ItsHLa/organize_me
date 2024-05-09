import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/electric_bill.dart';
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
      appBar: AppBar(),
      body: BlocBuilder<BillCubit, BillState>(
        builder: (context, state) {
          if (state is LoadingBill) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BillLoaded && state.bills.isNotEmpty) {
            return MyListView(
              dataList: const [],
              itemCount: state.bills.length,
              itemBuilder: (context, index) {
                ElectricBill current = state.bills[index] as ElectricBill;
                return ElectricBills(
                  commissionAmount: current.commissionAmount.toString(),
                  gov: current.gov,
                  invoiceNumber: current.invoiceNumber,
                  date: current.date,
                  time: current.time,
                  operationNumber: current.operationNumber,
                  billingNumber: current.billingNumber,
                  paymentAmount: current.paymentAmount.toString(),
                  subscriptionNumber: current.subscriptionNumber,
                );
              },
            );
          }
          return const Center(
            child: Text(
              'لا يوجد فواتير لعرضها',
              style: TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
