import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return const CircularProgressIndicator();
          } else if (state is BillLoaded && state.bills.isNotEmpty) {
            return MyListView(
                dataList: const [],
                itemCount: 100,
                itemBuilder: (context, index) {
                  // ElectricBills current = state.bill[index];
                  return ElectricBills(
                    commissionAmount: 0.toString(),
                    gov: 'اللاذقية',
                    invoiceNumber: '69899292',
                    date: ' 01/05/2024 18:11',
                    operationNumber: 's600068373161 ',
                    billingNumber: '254871',
                    paymentAmount: ' 3920 ',
                    subscriptionNumber: '157972',
                  );
                });
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
