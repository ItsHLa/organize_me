import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/cubit/bill_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_button.dart';

import '../../../services/functionality.dart';
import '../../input_text.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({
    super.key,
  });

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  String selectedYear = '';
  String selectedMonth = '';
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: SizedBox(
        // padding: EdgeInsets.all(8),
        height: 100,
        child: TextField(
          decoration: InputDecoration(
            suffix: Icon(
              Icons.search,
              color: appColorTheme,
            ),
            labelStyle: TextStyle(color: appColorTheme),
            hintStyle: TextStyle(color: appColorTheme),
            border: UnderlineInputBorder(
              //borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: appColorTheme),
            ),
            focusedBorder: UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: appColorTheme),
            ),
            enabledBorder: const UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (newcontext) => BlocProvider<BillCubit>.value(
                value: BlocProvider.of(context),
                child: BlocListener<BillCubit, BillState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is MonthlySpendingCalculated) {
                      Navigator.pop(context);
                    }
                  },
                  child: SimpleDialog(
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
                                    selectedMonth = value!;
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
                                      (int.parse(value) >
                                          DateTime.now().year)) {
                                    return 'يرجى ادخال السنة بشكل صحيح';
                                  } else {
                                    return null;
                                  }
                                },
                                labelText: 'ادخل السنة',
                                save: (value) {
                                  selectedYear = value!;
                                },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            MyButton(
                              onPressed: () {
                                if (ValidateInputData.validateField(key)) {
                                  key.currentState?.save();
                                  lastMonth = selectedMonth;
                                  lastYear = selectedYear;
                                  BlocProvider.of<BillCubit>(context)
                                      .monthlySpendingOneCategory(
                                          selectedYear, selectedMonth);
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
                ),
              ),
            );
          },
          readOnly: true,
          controller: TextEditingController(text: '$lastMonth / $lastYear'),
        ),
      ),
    );
  }
}
