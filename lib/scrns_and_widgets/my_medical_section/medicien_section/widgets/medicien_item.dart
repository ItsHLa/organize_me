import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/icon_form.dart';

class MedItem extends StatelessWidget {
  const MedItem({
    super.key,
    required this.medName,
    required this.interval,
    required this.shotTime,
    this.onPressedEdit,
    this.onPressedDelete,
  });

  final String medName;
  final int interval;
  final String shotTime;
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
                    Text('$interval عدد الساعات بين الجرعات'),
                    Text('$shotTime موعد أخذ الدواء ')
                  ],
                ),
              ),
              title: Row(
                children: [
                  const IconForm(
                    child: Icon(Icons.medication),
                  ),
                  const Spacer(),
                  Text(medName),
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
