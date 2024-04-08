import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/widgets/docs_number_item.dart';

import '../cubit/docs_num_cubit.dart';
import '../edit_phone_num.dart';

class DocsNumbers extends StatelessWidget {
  const DocsNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return DocsNumber(
          docsName: 'Docs Name',
          phoneNumber: "09976765465",
          onPressedCall: call,
          onPressedDelete: () {
            // BlocProvider.of<DocsNumCubit>(context).deletePhoneNumber(id);
          },
          onPressedEdit: () {
            showModalBottomSheet(
                context: context,
                builder: (newcontext) => BlocProvider<DocsNumCubit>.value(
                      value: BlocProvider.of(context),
                      child: const EditPhoneNumber(),
                    ));
          },
        );
      },
    );
  }
}

void call() {}