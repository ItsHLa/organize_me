import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/widgets/docs_number_item.dart';

class DocsNumbers extends StatelessWidget {
  const DocsNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const DocsNumber(
          docsName: 'Docs Name',
          phoneNumber: "09976765465",
          onPressed: call,
        );
      },
    );
  }
}

void call() {}