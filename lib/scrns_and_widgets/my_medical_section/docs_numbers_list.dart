import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/cubit/docs_num_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/models/doctors_contacts.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/widgets/docs_numbers_listview.dart';

class DocsNumbers extends StatelessWidget {
  const DocsNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocsNumCubit, DocsNumState>(
      builder: (context, state) {
        if (state is DocsNumLoadingData) {
          BlocProvider.of<DocsNumCubit>(context).loadDocsNumbers();
        }
        List<DoctorsContacts> contacts =
            BlocProvider.of<DocsNumCubit>(context).contacts;
        return contacts.isEmpty
            ? (state is! DocsNumLoaded
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Center(
                    child: Text(
                      "ليس لديك جهات اتصال بعد",
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
            : DocsNumbersListView(contacts: contacts);
      },
    );
  }
}
