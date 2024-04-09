import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/cubit/docs_num_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/models/doctors_contacts.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/widgets/docs_numbers_listview.dart';

class DocsNumbers extends StatelessWidget {
  const DocsNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DocsNumCubit>(context).loadDocsNumbers();
    return BlocBuilder<DocsNumCubit, DocsNumState>(
      builder: (context, state) {
        if (state is DocsNumLoadingData) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.docsNumber.isNotEmpty &&
            (state is DocsNumLoaded ||
                state is AddDocsNumSuccess ||
                state is DeleteDocsNumSuccess)) {
          return DocsNumbersListView(
            contacts: state.docsNumber as List<DoctorsContacts>,
          );
        } else {
          return const Center(
            child: Text(
              "ليس لديك جهات اتصال بعد",
              style: TextStyle(fontSize: 20),
            ),
          );
        }
      },
    );
  }
}
