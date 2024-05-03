import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/models/med.dart';

import '../../../../constants.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                //Icon(Icons.medication),
                subtitle: Text(
                    'موعد اخذ الدواء : ${med.shotTime} \n يؤخذ كل ${med.interval} ساعة'),
                title: Text(med.name),
                leading: const Icon(
                  Icons.medication,
                  color: blue,
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: onPressedEdit,
                    icon: const Icon(Icons.edit_outlined)),
                IconButton(
                    onPressed: onPressedDelete,
                    icon: const Icon(Icons.cancel_outlined))
              ],
            )
          ],
        ),
      ),
    );
  }
}
