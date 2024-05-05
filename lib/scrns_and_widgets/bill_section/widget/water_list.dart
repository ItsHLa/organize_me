import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

import '../cubit/bill_cubit.dart';
import '../models/water_bill.dart';
import 'water_bill_item.dart';

class WaterList extends StatelessWidget {
  const WaterList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BillCubit>(context).loadWater();
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<BillCubit, BillState>(
        builder: (context, state) {
          if (state is LoadingBill) {
            return const CircularProgressIndicator();
          } else if (state is BillLoaded && state.bills.isNotEmpty) {
            return MyListView(
                dataList: state.bills,
                itemCount: state.bills.length,
                itemBuilder: (context, index) {
                  WaterBill current = state.bills[index] as WaterBill;
                  return WaterBills(
                      gov: current.gov,
                      commissionAmount: current.commissionAmount.toString(),
                      receiptNumber: current.receiptNumber,
                      date: current.date,
                      operationNumber: current.operationNumber,
                      paymentAmount: current.commissionAmount.toString(),
                      barcodeNumber: current.barcodeNumber,
                      counterNumber: current.counterNumber);
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
