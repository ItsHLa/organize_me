import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/cubit/bill_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_button.dart';

import '../../../constants.dart';
import '../../../services/functionality.dart';
import '../../input_text.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  String year = '';
  String month = '';
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Form(
          key: key,
          child: Column(
            children: [
              SizedBox(
                  width: 200,
                  child: InputText(
                    validator: ValidateInputData.checkIfNull,
                    hint: '',
                    labelText: 'ادخل الشهر',
                    save: (value) {
                      month = value!;
                    },
                    keyboardType: TextInputType.number,
                  )),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 200,
                child: InputText(
                  validator: ValidateInputData.checkIfNull,
                  hint: '',
                  labelText: 'ادخل السنة',
                  save: (value) {
                    year = value!;
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              MyButton(
                  onPressed: () {
                    if (ValidateInputData.validateField(key)) {
                      key.currentState?.save();
                      print(year);
                      print(month);
                      BlocProvider.of<BillCubit>(context)
                          .monthlySpendingOneCategory(year, month);
                    }
                  },
                  icon: Icons.search,
                  label: 'ابحث')
            ],
          ),
        ),
      ],
    );
  }
}
