import 'package:flutter/material.dart';

import 'medicien_item.dart';

class MedsGridView extends StatelessWidget {
  const MedsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return const MedItem();
      },
    );
  }
}
