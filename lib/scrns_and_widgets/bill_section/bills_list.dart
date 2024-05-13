import 'package:flutter/cupertino.dart';
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

class BillList extends StatefulWidget {
  const BillList({super.key, required this.category});

  final String category;

  @override
  State<BillList> createState() => _BillListState();
}

class _BillListState extends State<BillList> {
  @override
  void initState() {
    super.initState();
    loadCategory(context, widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<BillCubit>(context)
                      .monthlySpendingOneCategory(
                          DateTime.now().year.toString(),
                          DateTime.now().month.toString());
                },
                icon: const Icon(Icons.arrow_back)),
            const Spacer()
          ],
        ),
        Expanded(
          child: BlocConsumer<BillCubit, BillState>(
            listener: (context, state) {
              if (state is TelecomFailed ||
                  state is ElectricFailed ||
                  state is WaterFailed) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('حصل خطأ اثناء تحميل فواتيرك')));
              }
            },
            builder: (context, state) {
              print(state);
              if (state.bills.isEmpty) {
                return const Center(
                  child: Text('لا يوجد فواتير لعرضها',
                      style: TextStyle(fontSize: 20)),
                );
              }

              return state is LoadingBill
                  ? Center(
                      child: CircularProgressIndicator(
                        color: appColorTheme,
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.bills.length,
                      itemBuilder: (context, index) {
                        switch (widget.category) {
                          case 'المياه':
                            if (state is WaterLoaded) {
                              WaterBill water = state.bills[index] as WaterBill;
                              return WaterBills(
                                counterNumber: water.counterNumber,
                                barcodeNumber: water.barcodeNumber,
                                receiptNumber: water.receiptNumber,
                                commissionAmount:
                                    water.commissionAmount.toString(),
                                gov: water.gov,
                                paymentAmount: water.paymentAmount.toString(),
                                date: water.date,
                                operationNumber: water.operationNumber,
                                time: water.time,
                              );
                            }
                            break;
                          case 'الاتصالات':
                            if (state is TelecomLoaded) {
                              TelecomBill telecom =
                                  state.bills[index] as TelecomBill;
                              return TelecomBills(
                                time: telecom.time,
                                operationNumber: telecom.operationNumber,
                                date: telecom.date,
                                paymentAmount: telecom.paymentAmount.toString(),
                                commissionAmount:
                                    telecom.commissionAmount.toString(),
                                invoiceNumber: telecom.invoiceNumber,
                                phoneNumberEmail: telecom.phoneNumberEmail,
                              );
                            }
                            break;
                          case 'الكهرباء':
                            if (state is ElectricLoaded) {
                              ElectricBill electric =
                                  state.bills[index] as ElectricBill;
                              return ElectricBills(
                                invoiceNumber: electric.invoiceNumber,
                                commissionAmount:
                                    electric.commissionAmount.toString(),
                                paymentAmount:
                                    electric.paymentAmount.toString(),
                                date: electric.date,
                                operationNumber: electric.operationNumber,
                                time: electric.time,
                                subscriptionNumber: electric.subscriptionNumber,
                                gov: electric.gov,
                                billingNumber: electric.billingNumber,
                              );
                            }
                            break;
                          default:
                            break;
                        }
                      },
                    );
              //  if (state is WaterLoaded ||
              //      state is ElectricLoaded ||
              //     state is TelecomLoaded) {
              //  ;
              // }
              return SizedBox();
            },
          ),
        )
      ],
    ));
  }
}

void loadCategory(BuildContext context, String category) {
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
  }
}