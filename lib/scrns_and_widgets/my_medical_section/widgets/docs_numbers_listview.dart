import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/models/doctors_contacts.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/widgets/docs_number_item.dart';

import '../cubit/docs_num_cubit.dart';
import '../edit_phone_num.dart';

class DocsNumbersListView extends StatelessWidget {
  const DocsNumbersListView({super.key, required this.contacts});

  final List<DoctorsContacts> contacts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return DocsNumber(
          docsName: contacts[index].name,
          phoneNumber: contacts[index].phone,
          onPressedCall: () {
            BlocProvider.of<DocsNumCubit>(context).call();
          },
          onPressedDelete: () {
            BlocProvider.of<DocsNumCubit>(context)
                .deletePhoneNumber(contacts[index].id);
          },
          onPressedEdit: () {
            showModalBottomSheet(
              context: context,
              builder: (newcontext) => BlocProvider<DocsNumCubit>.value(
                value: BlocProvider.of(context),
                child: EditPhoneNumber(contact: contacts[index]),
              ),
            );
          },
        );
      },
    );
  }
}
