/*
* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/widgets/input_phone_num.dart';
import 'package:organize_me/services/functionality.dart';

import '../../add_data_page.dart';
import 'cubit/docs_num_cubit.dart';
import 'models/doctors_contacts.dart';

class EditPhoneNumber extends StatefulWidget {
  const EditPhoneNumber({super.key, required this.contact});

  final DoctorsContacts contact;

  @override
  State<EditPhoneNumber> createState() => _EditPhoneNumber();
}

class _EditPhoneNumber extends State<EditPhoneNumber> {
  String editedName = '';
  String editedPhone = '';


  @override
  Widget build(BuildContext context) {
    return BlocListener<DocsNumCubit, DocsNumState>(

        },
        child: Form(

          child: InputDataPage(

            onPressed: () {

            },
            child: InputPhoneNumber(
              saveSpecialist: null,
              phoneNumberValidator: ValidateInputData.checkEditedPhoneNumber,
              saveName: (value) {
                ed = value ?? '';
              },
              savePhoneNumber: (value) {
                editedPhone = value ?? '';
              },
            ),
          ),
        ));
  }
}

*
* */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/services/functionality.dart';

import '../../add_data_page.dart';
import 'cubit/docs_num_cubit.dart';
import 'models/doctors_contacts.dart';

class EditPhoneNumber extends StatefulWidget {
  const EditPhoneNumber({super.key, required this.contact});

  final DoctorsContacts contact;

  @override
  State<EditPhoneNumber> createState() => _EditPhoneNumberState();
}

class _EditPhoneNumberState extends State<EditPhoneNumber> {
  String editClinicNumber = '';
  String editPhoneNumber = '';
  GlobalKey<FormState> numKey = GlobalKey();
  AutovalidateMode validateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: numKey,
      autovalidateMode: validateMode,
      child: BlocListener<DocsNumCubit, DocsNumState>(
        listener: (modalcontext, state) {
          if (state is AddDocsNumSuccess) {
            Navigator.of(modalcontext).pop();
          }
        },
        child: InputDataPage(
          labels: const ['رقم العيادة', 'رقم الطبيب'],
          hint: ['', ''],
          keyboardType: [TextInputType.number, TextInputType.number],
          validator: const [null, ValidateInputData.checkEditedPhoneNumber],
          save: [
            (value) {
              editClinicNumber = value ?? widget.contact.clinicPhone;
            },
            (value) {
              editPhoneNumber = value ?? widget.contact.phone;
            }
          ],
          icon: Icons.add_call,
          labelButton: 'تعديل جهة الاتصال',
          onPressed: () {
            numKey.currentState?.save();
            BlocProvider.of<DocsNumCubit>(context).editPhoneNumber(
              widget.contact.id,
              editClinicNumber,
              editPhoneNumber,
            );
          },
        ),
      ),
    );
  }
}
