import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/cubit/bill_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_button.dart';

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
    return BlocListener<BillCubit, BillState>(
      listener: (context, state) {
        if (state is MonthlySpendingCalculated) {
          Navigator.pop(context);
        }
      },
      child: SizedBox(
        width: 150,
        child: InputText(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                children: [
                  Form(
                    key: key,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            width: 200,
                            child: InputText(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'لا يمكن هذا الحقل ان يكون فارغ';
                                } else if (value.isNotEmpty &&
                                    (int.parse(value) < 0 ||
                                        int.parse(value) > 12)) {
                                  return 'يرجى ادخال الشهر بشكل صحيح';
                                } else {
                                  return null;
                                }
                              },
                              labelText: 'ادخل الشهر',
                              save: (value) {
                                month = value!;
                              },
                              keyboardType: TextInputType.number,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 200,
                          child: InputText(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'لا يمكن هذا الحقل ان يكون فارغ';
                              } else if (value.isNotEmpty &&
                                  (int.parse(value) > DateTime.now().year)) {
                                return 'يرجى ادخال السنة بشكل صحيح';
                              } else {
                                return null;
                              }
                            },
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
                              BlocProvider.of<BillCubit>(context)
                                  .monthlySpendingOneCategory(year, month);
                              lastSelectedMonth = month;
                              lastSelectedYear = year;
                            }
                          },
                          icon: Icons.search,
                          label: 'ابحث',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          readOnly: true,
          controller: TextEditingController(text: '$month / $year'),
        ),
      ),
    );
  }
}
