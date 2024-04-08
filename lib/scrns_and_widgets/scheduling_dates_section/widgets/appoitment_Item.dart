import 'package:flutter/material.dart';

class AppoitmentItem extends StatelessWidget {
  const AppoitmentItem({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListView(
      children: [
        Row(
          children: [
            const Text('Appoitment Name'),
            const Spacer(),
            IconButton(
                onPressed: () {
                  // print(index);
                  // BlocProvider.of<AppoitmentCubit> (context).deleteAppoitment();
                },
                icon: const Icon(Icons.cancel_outlined))
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: const Text('Apppoitment Details'),
        )
      ],
    ));
  }
}
