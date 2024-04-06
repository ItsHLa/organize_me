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
            Text('Appoitment Name'),
            Spacer(),
            IconButton(
                onPressed: () {
                  // print(index);
                  // BlocProvider.of<AppoitmentCubit> (context).deleteAppoitment();
                },
                icon: Icon(Icons.cancel_outlined))
          ],
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text('Apppoitment Details'),
        )
      ],
    ));
  }
}
