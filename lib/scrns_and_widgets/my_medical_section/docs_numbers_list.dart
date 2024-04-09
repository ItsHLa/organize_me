import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/cubit/docs_num_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/widgets/docs_numbers_listview.dart';

import 'models/doctors_contacts.dart';

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
                child: Text('لا يوجد جهات اتصال'),
              )
            : (state is DocsNumLoadingData
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : DocsNumbersListView(contacts: contacts));
      },
    );
  }
}
