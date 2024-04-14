import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/icon_form.dart';

class DocsNumber extends StatelessWidget {
  const DocsNumber({
    super.key,
    required this.docsName,
    required this.phoneNumber,
    this.onPressedEdit,
    this.onPressedCall,
    this.onPressedDelete,
  });

  final String docsName;
  final String phoneNumber;
  final void Function()? onPressedEdit;
  final void Function()? onPressedCall;
  final void Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: const IconForm(
          child: Icon(Icons.person_2_outlined),
        ),
        title: Row(
          children: [
            Column(
              children: [Text(docsName), Text(phoneNumber)],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onPressedEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onPressedDelete,
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.call),
          onPressed: onPressedCall,
        ),
      ),
    );
  }
}
