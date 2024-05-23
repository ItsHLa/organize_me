import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/widgets/docs_numbers_listview.dart';
import 'package:organize_me/scrns_and_widgets/no_content.dart';

import 'cubit/docs_num_cubit.dart';

class DocsNumbers extends StatelessWidget {
  const DocsNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DocsNumCubit>(context).loadDocsNumbers();
    return BlocBuilder<DocsNumCubit, DocsNumState>(
      builder: (context, state) {
        if (state is DocsNumLoadingData) {
          return Center(
              child: CircularProgressIndicator(
            color: appColorTheme,
          ));
        } else if (state.docsNumber.isNotEmpty &&
            (state is DocsNumLoaded ||
                state is AddDocsNumSuccess ||
                state is DeleteDocsNumSuccess)) {
          return DocsNumbersListView(
            contacts: state.docsNumber,
          );
        } else {
          return const Center(
            child: NoContent(
              text: "ليس لديك جهات اتصال بعد",
            ),
          );
        }
      },
    );
  }
}
