import 'package:flutter/material.dart';

class MedItem extends StatelessWidget {
  const MedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.white54),
            child: const Icon(Icons.medication),
          ),
          const Row(
            children: [Text('setamol')],
          )
        ],
      ),
    );
  }
}
