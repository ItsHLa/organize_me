import 'package:flutter/material.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

import '../../../constants.dart';
import '../../../services/functionality.dart';
import '../../date_time_picker.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  DateTime? selectedDate;

  String date = '';
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          SizedBox(
              height: 48,
              width: 290,
              child: Form(
                key: key,
                child: MyDatePicker(
                  labelText: '',
                  validator: (value) {
                    if (selectedDate != null &&
                        (selectedDate!.year > DateTime.now().year)) {
                      return 'لا يمكن السنة المختارة ان تكون اكبر من السنة الحالية';
                    }
                  },
                  onTap: () async {
                    selectedDate =
                        await SimpleMonthYearPicker.showMonthYearPickerDialog(
                      context: context,
                      disableFuture: false,
                      selectionColor: blue,
                      monthTextStyle: const TextStyle(),
                      yearTextStyle: const TextStyle(),
                      titleTextStyle: const TextStyle(fontSize: 20),
                    );
                    setState(() {
                      date = '${selectedDate?.year} / ${selectedDate?.month}';
                    });
                  },
                  controller: TextEditingController(text: date),
                ),
              )),
          IconButton(
              onPressed: () {
                if (ValidateInputData.validateField(key)) {}
              },
              icon: Icon(
                Icons.search_outlined,
                color: appColorTheme,
              ))
        ],
      ),
    );
  }
}
