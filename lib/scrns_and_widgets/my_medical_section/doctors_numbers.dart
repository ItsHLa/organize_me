import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/floating_action_button.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/widgets/docs_numbers_listview.dart';

import '../app_bar.dart';
import 'add_phone_num.dart';
import 'cubit/docs_num_cubit.dart';

class MedsAndDocs extends StatelessWidget {
  const MedsAndDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocsNumCubit>(
      create: (context) => DocsNumCubit(),
      child: Scaffold(
        floatingActionButton: MyFab(
          icon: Icons.add_call,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (newcontext) => BlocProvider<DocsNumCubit>.value(
                      value: BlocProvider.of(context),
                      child: const AddPhoneNum(),
                    ));
          },
        ),
        body:
            const Column(children: [MAppBar(), Expanded(child: DocsNumbers())]),
      ),
    );
  }
}
