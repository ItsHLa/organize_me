import 'package:flutter/material.dart';

class MedItem extends StatelessWidget {
  const MedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(18)),
                  child: const Icon(Icons.medication)),
              title: const Text('Setamol'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Take 2 pills'),
          )
        ],
      ),
    );
  }
}
