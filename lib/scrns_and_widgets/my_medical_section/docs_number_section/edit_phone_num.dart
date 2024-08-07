
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
  TextEditingController editClinicNumber = TextEditingController();
  TextEditingController editPhoneNumber = TextEditingController();

  @override
  void initState() {
    editClinicNumber.text = widget.contact.clinicPhone;
    editPhoneNumber.text = widget.contact.phone;
    super.initState();
  }

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
          controllers: [editClinicNumber, editPhoneNumber],
          labels: const ['رقم العيادة', 'رقم الطبيب'],
          keyboardType: const [TextInputType.number, TextInputType.number],
          validator: const [
            ValidateInputData.checkEditedClinicNumber,
            ValidateInputData.checkEditedPhoneNumber
          ],
          save: [
            (value) {
              editClinicNumber.text = value!;
            },
            (value) {
              editPhoneNumber.text = value!;
            }
          ],
          icon: Icons.add_call,
          labelButton: 'تعديل جهة الاتصال',
          onPressed: () {
            if (ValidateInputData.validateField(numKey)) {
              numKey.currentState?.save();
              BlocProvider.of<DocsNumCubit>(context).editPhoneNumber(
                widget.contact.id,
                editClinicNumber.text,
                editPhoneNumber.text,
              );
            }
          },
        ),
      ),
    );
  }
}
