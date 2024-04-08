import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/input_text.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/cubit/docs_num_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/models/doctors_contacts.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/widgets/input_phone_num.dart';

class EditPhoneNumber extends StatelessWidget {
  final DoctorsContacts contact;
  const EditPhoneNumber({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DocsNumCubit, DocsNumState>(
      listener: (context, state) {
        if (state is AddDocsNumSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: InputPhoneNumber(
        onPressed: (numKey, name, phone) {
          if (name.isEmpty && phone.isEmpty) {
            InputText.validateField(numKey);
            return;
          }
          BlocProvider.of<DocsNumCubit>(context).editPhoneNumber(
            contact.id,
            name,
            phone,
          );
        },
      ),
    );
  }
}
