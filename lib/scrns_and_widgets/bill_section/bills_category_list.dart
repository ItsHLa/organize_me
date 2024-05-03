/*
* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/cubit/bill_cubit.dart';

import 'widget/bili_category_item.dart';

class BillsList extends StatelessWidget {
  const BillsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      BillItem(
        onTap: () {
          BlocProvider.of<BillCubit>(context).loadElectric();
        },
        billIcon:const Icon(
          Icons.electric_bolt,
          color: Color.fromRGBO(219, 200, 109, 1),
        ), label: 'كهرباء',
      ),
      const SizedBox(
        width: 3,
      ),
      BillItem(
        label: 'مياه',
        onTap: () {
          BlocProvider.of<BillCubit>(context).loadWater();
        },
        billIcon:  const Icon(
          Icons.water_drop,
          color: Color.fromRGBO(7, 144, 166, 1),
        )
      ),
      const SizedBox(
        width: 3,
      ),
      BillItem(
        label: 'اتصالات',
        onTap: () {
          BlocProvider.of<BillCubit>(context).loadTelecom();
        },
        billIcon: const Icon(
          Icons.call_end,
          color: Color.fromRGBO(109, 124, 65, 1),
        ),
      ),
    ]);
  }
}

*
*
* */
