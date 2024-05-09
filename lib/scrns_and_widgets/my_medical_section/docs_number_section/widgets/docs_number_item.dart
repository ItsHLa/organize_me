import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/icon_form.dart';

class DocsNumber extends StatelessWidget {
  const DocsNumber({
    super.key,
    required this.docsName,
    required this.spec,
    this.onPressedEdit,
    this.onPressedCall,
    this.onPressedDelete,
    required this.onTap,
  });

  final String docsName;
  final String spec;
  final Function()? onTap;
  final void Function()? onPressedEdit;
  final void Function()? onPressedCall;
  final void Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: const IconForm(
            child: Icon(Icons.person_2_outlined),
          ),
          title: Text(docsName),
          subtitle: Text(spec),
          trailing: IconButton(
            icon: const Icon(
              Icons.call,
              color: green,
            ),
            onPressed: onPressedCall,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
