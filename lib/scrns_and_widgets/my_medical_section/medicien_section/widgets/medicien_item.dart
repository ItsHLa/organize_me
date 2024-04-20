import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/models/med.dart';

class MedItem extends StatelessWidget {
  const MedItem({
    super.key,
    required this.med,
    this.onPressedEdit,
    this.onPressedDelete,
  });

  final Med med;

  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
              subtitle: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('${med.interval} عدد الساعات بين الجرعات'),
                    Text('${med.shotTime} موعد أخذ الدواء ')
                  ],
                ),
              ),
              title: Row(
                children: [
                  const Icon(Icons.medication),
                  const Spacer(),
                  Text(med.name),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: onPressedEdit, child: const Text('تعديل')),
              TextButton(onPressed: onPressedDelete, child: const Text('حذف')),
            ],
          )
        ],
      ),
    );
  }
}
