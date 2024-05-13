import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/functionality.dart';
import '../../add_data_page.dart';
import 'cubit/docs_num_cubit.dart';

class AddPhoneNum extends StatefulWidget {
  const AddPhoneNum({super.key});

  @override
  State<AddPhoneNum> createState() => _AddPhoneNumState();
}

class _AddPhoneNumState extends State<AddPhoneNum> {
  TextEditingController newName = TextEditingController();
  TextEditingController newPhone = TextEditingController();
  TextEditingController specialty = TextEditingController();
  TextEditingController clinicPhone = TextEditingController();

  GlobalKey<FormState> numKey = GlobalKey();
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocListener<DocsNumCubit, DocsNumState>(
        listener: (context, state) {
          if (state is AddDocsNumSuccess) {
            Navigator.of(context).pop();
          }
        },
        child: Form(
          key: numKey,
          autovalidateMode: validateMode,
          child: InputDataPage(
            save: [
              (value) {
                newName.text = value!;
              },
              (value) {
                specialty.text = value!;
              },
              (value) {
                newPhone.text = value!;
              },
              (value) {
                clinicPhone.text = value!;
              }
            ],
            validator: const [
              ValidateInputData.checkIfNull,
              ValidateInputData.checkIfNull,
              ValidateInputData.checkPhoneNumber,
              null
            ],
            keyboardType: const [
              null,
              null,
              TextInputType.number,
              TextInputType.number
            ],
            hint: const ['', '', '', ''],
            labels: const ['الاسم', 'الاختصاص', 'رقم الطبيب', 'رقم العيادة'],
            icon: Icons.add_call,
            labelButton: 'اضف جهة الاتصال',
            onPressed: () {
              if (ValidateInputData.validateField(numKey)) {
                numKey.currentState?.save();
                BlocProvider.of<DocsNumCubit>(context).addPhoneNumber(
                    newName.text,
                    newPhone.text,
                    specialty.text,
                    clinicPhone.text);
              } else {
                validateMode = AutovalidateMode.always;
              }
            },
          ),
        ));
  }
}
