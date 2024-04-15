import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/floating_action_button.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/docs_numbers_list.dart';

import 'add_phone_num.dart';
import 'cubit/docs_num_cubit.dart';
import 'models/doctors_contacts.dart';

class MedsAndDocs extends StatefulWidget {
  const MedsAndDocs({super.key});

  @override
  State<MedsAndDocs> createState() => _MedsAndDocsState();
}

class _MedsAndDocsState extends State<MedsAndDocs> {
  void _getAllContacts() async {
    BlocProvider.of<DocsNumCubit>(context).contacts =
        await DoctorsContacts.getAllContacts();
  }

  @override
  void initState() {
    _getAllContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocsNumCubit, DocsNumState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: MyFab(
            icon: Icons.add_call,
            onPressed: () async {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (newcontext) => BlocProvider<DocsNumCubit>.value(
                  value: BlocProvider.of(context),
                  child: const AddPhoneNum(),
                ),
              );
            },
          ),
          body: const Column(
            children: [
              Expanded(
                child: DocsNumbers(),
              ),
            ],
          ),
        );
      },
    );
  }
}
