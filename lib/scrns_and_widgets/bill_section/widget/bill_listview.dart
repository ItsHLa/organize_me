import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/cubit/bill_cubit.dart';

import 'bill_listview_category.dart';

class BillView extends StatelessWidget {
  const BillView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillCubit, BillState>(
      builder: (context, state) {
        if (state is BillLoaded) {
          return BillsListView(
            typeOfBill: state.typeOfBill,
            bill: state.bills,
          );
        }
        if (state is LoadingBill) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadingBillFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.msg)));
        }
        return const Center(child: Text('لا يوجد فواتير لعرضها'));
      },
    );
  }
}
