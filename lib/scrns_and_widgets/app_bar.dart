import 'package:flutter/material.dart';

import '../constants.dart';

class MAppBar extends StatelessWidget {
  const MAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'OrganizeMe',
        style: TextStyle(color: deepPurple),
      ),
      actions: const [
        IconButton(onPressed: null, icon: Icon(Icons.wb_sunny_outlined)),
        IconButton(
            onPressed: null, icon: Icon(Icons.energy_savings_leaf_outlined))
      ],
    );
  }
}
