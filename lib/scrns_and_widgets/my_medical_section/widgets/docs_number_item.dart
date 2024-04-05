import 'package:flutter/material.dart';

class DocsNumber extends StatelessWidget {
  const DocsNumber(
      {super.key, required this.docsName, required this.phoneNumber});

  final String docsName;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person_2_outlined),
      title: Text(docsName),
      trailing: IconButton(
        icon: const Icon(Icons.call),
        onPressed: () {},
      ),
    );
  }
}
