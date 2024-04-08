import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/widgets/input_phone_num.dart';

import 'cubit/docs_num_cubit.dart';

class AddPhoneNum extends StatelessWidget {
  const AddPhoneNum({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DocsNumCubit, DocsNumState>(
      listener: (context, state) {
        if (state is AddDocsNumSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: InputPhoneNumber(
        onPressed: () {
          // BlocProvider.of<DocsNumCubit>(context).addPhoneNumber(name, phoneNumber);
        },
      ),
    );
  }
}
