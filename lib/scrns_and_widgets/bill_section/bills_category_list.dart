import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/cubit/bill_cubit.dart';

import 'widget/bili_category_item.dart';

class BillsList extends StatelessWidget {
  const BillsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.horizontal,
          children: [
            BillItem(
              onTap: () {
                BlocProvider.of<BillCubit>(context).loadElectric();
              },
              billTitle: 'فواتير الكهرباء',
            ),
            const SizedBox(
              width: 3,
            ),
            BillItem(
              onTap: () {
                BlocProvider.of<BillCubit>(context).loadWater();
              },
              billTitle: 'فواتير المياه',
            ),
            const SizedBox(
              width: 3,
            ),
            BillItem(
              onTap: () {
                BlocProvider.of<BillCubit>(context).loadTelecom();
              },
              billTitle: 'فواتير الاتصالات',
            )
          ],
        ),
      ),
    ]);
  }
}
