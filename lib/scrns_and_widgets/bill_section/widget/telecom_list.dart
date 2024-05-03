import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/telecom_bill_item.dart';
import 'package:organize_me/scrns_and_widgets/my_list_view.dart';

import '../cubit/bill_cubit.dart';
import '../models/telecom_bill.dart';

class TelecomList extends StatelessWidget {
  const TelecomList({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BillCubit>(context).loadTelecom();
    return Scaffold(
      body: BlocBuilder<BillCubit, BillState>(
        builder: (context, state) {
          if (state is LoadingBill) {
            return const CircularProgressIndicator();
          } else if (state is BillLoaded) {
            return MyListView(
                dataList: state.bill,
                itemCount: state.bill.length,
                itemBuilder: (context, index) {
                  TelecomBill currentBill = state.bill[index];
                  return TelecomBills(
                    paymentAmount: '${currentBill.paymentAmount}',
                    operationNumber: currentBill.operationNumber,
                    date: currentBill.date,
                    phoneNumberEmail: currentBill.phoneNumberEmail,
                    commissionAmount: currentBill.commissionAmount.toString(),
                  );
                });
          } else {
            return const Text(
              'لا يوجد فواتير لغرضها',
              style: TextStyle(fontSize: 20),
            );
          }
        },
      ),
    );
  }
}
