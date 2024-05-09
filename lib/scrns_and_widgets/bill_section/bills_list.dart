import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/cubit/bill_cubit.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/models/telecom_bill.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/electric_bill_item.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/telecom_bill_item.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/widget/water_bill_item.dart';

import 'models/electric_bill.dart';
import 'models/water_bill.dart';

class BillList extends StatelessWidget {
  const BillList({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    switch (category) {
      case 'المياه':
        BlocProvider.of<BillCubit>(context).loadWater();
        break;
      case 'الاتصالات':
        BlocProvider.of<BillCubit>(context).loadTelecom();
        break;
      case 'الكهرباء':
        BlocProvider.of<BillCubit>(context).loadElectric();
        break;
      default:
        break;
    }
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<BillCubit, BillState>(
        listener: (context, state) {
          if (state is LoadingBillFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('حصل خطأ اثناء تحميل فواتيرك')));
          }
        },
        builder: (context, state) {
          print(state);
          if (state is BillLoaded) {
            return ListView.builder(
              itemCount: state.bills.length,
              itemBuilder: (context, index) {
                switch (category) {
                  case 'المياه':
                    WaterBill water = state.bills[index] as WaterBill;
                    WaterBills(
                      counterNumber: water.counterNumber,
                      barcodeNumber: water.barcodeNumber,
                      receiptNumber: water.receiptNumber,
                      commissionAmount: water.commissionAmount.toString(),
                      gov: water.gov,
                      paymentAmount: water.paymentAmount.toString(),
                      date: water.date,
                      operationNumber: water.operationNumber,
                      time: water.time,
                    );
                    break;
                  case 'الاتصالات':
                    TelecomBill telecom = state.bills[index] as TelecomBill;
                    TelecomBills(
                      time: telecom.time,
                      operationNumber: telecom.operationNumber,
                      date: telecom.date,
                      paymentAmount: telecom.paymentAmount.toString(),
                      commissionAmount: telecom.commissionAmount.toString(),
                      invoiceNumber: telecom.invoiceNumber,
                      phoneNumberEmail: telecom.phoneNumberEmail,
                    );
                    break;
                  case 'الكهرباء':
                    ElectricBill electric = state.bills[index] as ElectricBill;
                    ElectricBills(
                      invoiceNumber: electric.invoiceNumber,
                      commissionAmount: electric.commissionAmount.toString(),
                      paymentAmount: electric.paymentAmount.toString(),
                      date: electric.date,
                      operationNumber: electric.operationNumber,
                      time: electric.time,
                      subscriptionNumber: electric.subscriptionNumber,
                      gov: electric.gov,
                      billingNumber: electric.billingNumber,
                    );
                    break;
                }
              },
            );
          } else if (state is LoadingBill) {
            return Center(
              child: CircularProgressIndicator(
                color: appColorTheme,
              ),
            );
          } else if (state.bills.isEmpty) {
            return const Center(
              child:
                  Text('لا يوجد فواتير لعرضها', style: TextStyle(fontSize: 40)),
            );
          }
          return const Center(
            child:
                Text('لا يوجد فواتير لعرضها', style: TextStyle(fontSize: 40)),
          );
        },
      ),
    );
  }
}
