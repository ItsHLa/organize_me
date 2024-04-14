import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/cubit/docs_num_cubit.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails(
      {super.key,
      this.onPressedDelete,
      this.onPressedEdit,
      required this.contactName,
      required this.contactNumber});

  final void Function()? onPressedDelete;
  final void Function()? onPressedEdit;
  final String contactName;
  final String contactNumber;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DocsNumCubit, DocsNumState>(
      listener: (context, state) {
        if (state is DeleteDocsNumSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: AlertDialog(
        title: Text(
          contactName,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          contactNumber,
          style: TextStyle(fontSize: 20),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: onPressedEdit,
            child: const Text('تعديل'),
          ),
          TextButton(
            onPressed: onPressedDelete,
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
