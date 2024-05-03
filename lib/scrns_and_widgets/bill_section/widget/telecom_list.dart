import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
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
          } else if (state is BillLoaded && state.bills.isNotEmpty) {
            return MyListView(
              dataList: state.bills,
              itemCount: state.bills.length,
              itemBuilder: (context, index) {
                TelecomBill currentBill = state.bills[index] as TelecomBill;
                return TelecomBills(
                  paymentAmount: '${currentBill.paymentAmount}',
                  operationNumber: currentBill.operationNumber,
                  date: currentBill.date,
                  phoneNumberEmail: currentBill.phoneNumberEmail,
                  commissionAmount: currentBill.commissionAmount.toString(),
                );
              },
            );
          } else {
            return noBillsToShow;
          }
        },
      ),
    );
  }
}
