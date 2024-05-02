import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/cubit/docs_num_cubit.dart';

import '../../icon_form.dart';
import 'models/doctors_contacts.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails(
      {super.key,
      this.onPressedDelete,
      this.onPressedEdit,
      required this.contact,
      required this.idx});

  final void Function()? onPressedDelete;
  final void Function()? onPressedEdit;
  final DoctorsContacts contact;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: onPressedEdit,
            child: const Text('تعديل'),
          ),
          TextButton(
            onPressed: onPressedDelete,
            child: const Text('حذف'),
          ),
        ],
      ),
      body: Column(
        children: [
          const IconForm(
            child: Icon(
              Icons.person_2_outlined,
              size: 40,
            ),
          ),
          ListTile(
              title: BlocBuilder<DocsNumCubit, DocsNumState>(
                buildWhen: (previous, current) => current is AddDocsNumSuccess,
                builder: (context, state) {
                  return Text(
                    state.docsNumber[idx].name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  );
                },
              ),
              subtitle: const Text('دكتور',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          ListTile(
            title: BlocBuilder<DocsNumCubit, DocsNumState>(
              buildWhen: (previous, current) => current is AddDocsNumSuccess,
              builder: (context, state) {
                return Text(
                  state.docsNumber[idx].phone,
                  style: const TextStyle(fontSize: 20),
                );
              },
            ),
            trailing: IconButton(
              onPressed: () {
                BlocProvider.of<DocsNumCubit>(context).call(contact.phone);
              },
              icon: const Icon(Icons.call),
              color: green,
            ),
          )
        ],
      ),
    );
  }
}
