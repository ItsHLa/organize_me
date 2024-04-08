import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/models/doctors_contacts.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/widgets/docs_number_item.dart';

import '../cubit/docs_num_cubit.dart';
import '../edit_phone_num.dart';

class DocsNumbers extends StatelessWidget {
  const DocsNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocsNumCubit, DocsNumState>(
      builder: (context, state) {
        List<DoctorsContacts> contacts =
            BlocProvider.of<DocsNumCubit>(context).contacts;
        return contacts.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return DocsNumber(
                    docsName: contacts[index].name,
                    phoneNumber: contacts[index].phone,
                    onPressedCall: call,
                    onPressedDelete: () {
                      BlocProvider.of<DocsNumCubit>(context)
                          .deletePhoneNumber(contacts[index].id);
                    },
                    onPressedEdit: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (newcontext) =>
                            BlocProvider<DocsNumCubit>.value(
                          value: BlocProvider.of(context),
                          child: EditPhoneNumber(contact: contacts[index]),
                        ),
                      );
                    },
                  );
                },
              );
      },
    );
  }
}

void call() {}
