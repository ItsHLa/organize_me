import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/cubit/docs_num_cubit.dart';

import '../../icon_form.dart';
import 'models/doctors_contacts.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({
    super.key,
    this.onPressedDelete,
    this.onPressedEdit,
    required this.contact,
    required this.idx,
  });

  final void Function()? onPressedDelete;
  final void Function()? onPressedEdit;
  final DoctorsContacts contact;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocsNumCubit, DocsNumState>(
      builder: (context, state) {
        if (state is DeleteDocsNumSuccess && state.docsNumber.isEmpty) {
          return Container();
        }
        if (state.docsNumber.length <= idx) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                  onPressed: onPressedEdit,
                  child: Text(
                    'تعديل',
                    style: TextStyle(color: appColorTheme),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<DocsNumCubit>(context)
                        .deletePhoneNumber(contact.id);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'حذف',
                    style: TextStyle(color: appColorTheme),
                  ),
                ),
              ],
            ),
            body: const Center(
              child: Text(
                'تعذر ايجاد جهة الاتصال',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          );
        }
        final doctorContact = state.docsNumber[idx];
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: onPressedEdit,
                child: Text(
                  'تعديل',
                  style: TextStyle(color: appColorTheme),
                ),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<DocsNumCubit>(context)
                      .deletePhoneNumber(contact.id);
                  Navigator.pop(context);
                },
                child: Text(
                  'حذف',
                  style: TextStyle(color: appColorTheme),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const IconForm(
                  child: Icon(
                    Icons.person_2_outlined,
                    size: 40,
                  ),
                ),
                ListTile(
                  title: Text(
                    doctorContact.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                  subtitle: Text(
                    doctorContact.specialist,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('رقم الطبيب'),
                  subtitle: Text(doctorContact.phone),
                  trailing: IconButton(
                    onPressed: () {
                      BlocProvider.of<DocsNumCubit>(context)
                          .call(contact.phone);
                    },
                    icon: const Icon(Icons.call),
                    color: green,
                  ),
                ),
                ListTile(
                  title: const Text('رقم العيادة'),
                  subtitle: Text(doctorContact.clinicPhone),
                  trailing: IconButton(
                    onPressed: () {
                      BlocProvider.of<DocsNumCubit>(context)
                          .call(contact.clinicPhone);
                    },
                    icon: const Icon(Icons.call),
                    color: green,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
