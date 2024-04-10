import 'package:flutter/material.dart';

import '../../app_bar.dart';
import 'meds_grid.dart';

class MedsPage extends StatelessWidget {
  const MedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [MAppBar(), MedsGrid()],
      ),
    );
  }
}
