import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/docs_numbers_list.dart';

import 'add_phone_num.dart';
import 'cubit/docs_num_cubit.dart';

class MedsAndDocs extends StatelessWidget {
  const MedsAndDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اطبائي'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColorTheme,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add_call,
          color: Colors.white60,
        ),
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
  }
}
