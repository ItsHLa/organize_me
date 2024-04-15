import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/icon_form.dart';

class DocsNumber extends StatelessWidget {
  const DocsNumber({
    super.key,
    required this.docsName,
    required this.phoneNumber,
    this.onPressedEdit,
    this.onPressedCall,
    this.onPressedDelete,
    required this.onTap,
  });

  final String docsName;
  final String phoneNumber;
  final Function()? onTap;
  final void Function()? onPressedEdit;
  final void Function()? onPressedCall;
  final void Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(8),
        leading: const IconForm(
          child: Icon(Icons.person_2_outlined),
        ),
        title: Row(
          children: [
            Column(
              children: [Text(docsName), Text(phoneNumber)],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.call,
            color: green,
          ),
          onPressed: onPressedCall,
        ),
      ),
    );
  }
}
