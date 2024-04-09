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
        BlocProvider.of<DocsNumCubit>(context).loadDocsNumbers();
        if (state.docsNumber.isEmpty) {
          return const Center(
            child: Text('لا يوجد جهات اتصال'),
          );
        } else {
          return (state is DocsNumLoadingData
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : DocsNumbersListView(
                  contacts: state.docsNumber as List<DoctorsContacts>));
        }
      },
    );
  }
}
