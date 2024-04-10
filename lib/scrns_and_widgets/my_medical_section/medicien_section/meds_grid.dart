import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/widgets/medicien_grid_view.dart';

class MedsGrid extends StatelessWidget {
  const MedsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: MedsGridView());
  }
}
