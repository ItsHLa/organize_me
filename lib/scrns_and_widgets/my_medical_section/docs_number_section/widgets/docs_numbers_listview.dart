import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/docs_num_cubit.dart';
import '../edit_phone_num.dart';
import '../models/doctors_contacts.dart';
import 'docs_number_item.dart';

class DocsNumbersListView extends StatelessWidget {
  const DocsNumbersListView({super.key, required this.contacts});

  final List<DoctorsContacts> contacts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
