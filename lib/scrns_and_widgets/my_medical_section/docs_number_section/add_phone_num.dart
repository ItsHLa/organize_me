import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/input_text.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/widgets/input_phone_num.dart';

import '../../add_data_page.dart';
import 'cubit/docs_num_cubit.dart';

class AddPhoneNum extends StatefulWidget {
  const AddPhoneNum({super.key});

  @override
  State<AddPhoneNum> createState() => _AddPhoneNumState();
}

class _AddPhoneNumState extends State<AddPhoneNum> {
  String newName = '';
  String newPhone = '';
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
            icon: Icons.add_call,
            label: 'اضف جهة الاتصال',
            onPressed: () {
              if (InputText.validateField(numKey)) {
                numKey.currentState?.save();
                BlocProvider.of<DocsNumCubit>(context).addPhoneNumber(
                  newName,
                  newPhone,
                );
              } else {
                validateMode = AutovalidateMode.always;
              }
            },
            child: InputPhoneNumber(
              saveName: (value) {
                newName = value ?? '';
              },
              savePhoneNumber: (value) {
                newPhone = value ?? '';
              },
            ),
          ),
        ));
  }
}
