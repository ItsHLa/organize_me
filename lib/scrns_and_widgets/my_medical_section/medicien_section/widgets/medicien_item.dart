import 'package:flutter/material.dart';

class MedItem extends StatelessWidget {
  const MedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            subtitle: const Text('2 pills'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const MedicienDetails(),
              );
            },
            leading: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(18)),
                child: const Icon(Icons.medication)),
            title: const Text('Setamol'),
          ),
        ],
      ),
    );
  }
}

class MedicienDetails extends StatelessWidget {
  const MedicienDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: const Text('سيتامول'),
      content: const SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Chip(
                label: Text(
                  'عدد الجرعات :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text('2 '),
            ],
          ),
          Text('مواعيد اخذ الدواء :',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('7 : 00 '),
          Text('7 : 00 '),
          Text('7 : 00 '),
          Text('7 : 00 '),
          Text('7 : 00 '),
          Text('7 : 00 '),
          Text('7 : 00 '),
          Text('7 : 00 '),
          Text('7 : 00 '),
          Text('7 : 00 '),
        ]),
      ),
      actions: [
        TextButton(
            onPressed: () {
              print('update ++++++');
            },
            child: const Text('تعديل')),
        TextButton(
            onPressed: () {
              print('delete ++++++++');
            },
            child: const Text('حذف')),
      ],
    );
  }
}
