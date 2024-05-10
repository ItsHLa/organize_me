import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/widgets/input_phone_num.dart';

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
            icon: Icons.add_call,
            label: 'اضف جهة الاتصال',
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
            child: InputPhoneNumber(
              nameValidator: ValidateInputData.checkIfNull,
              specialistValidator: ValidateInputData.checkIfNull,
              phoneNumberValidator: ValidateInputData.checkPhoneNumber,
              saveClinicNumber: (value) {
                clinicPhone.text = value!;
              },
              saveSpecialist: (value) {
                specialty.text = value!;
              },
              saveName: (value) {
                newName.text = value!;
              },
              savePhoneNumber: (value) {
                newPhone.text = value!;
              },
            ),
          ),
        ));
  }
}
