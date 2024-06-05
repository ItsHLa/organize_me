import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTile(
              shape: StadiumBorder(),
              leading: IconButton(
                  onPressed: onPressedDelete,
                  icon: const Icon(Icons.cancel_outlined)),
              title: Text(
                med.name,
                textAlign: TextAlign.right,
              ),
              trailing: Image.asset('images/drug.png'),
              iconColor: appColorTheme,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      IconButton(
                          onPressed: onPressedEdit,
                          icon: const Icon(Icons.edit_outlined)),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            'موعد أخذ الدواء : ${med.shotTime} ',
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            ' يؤخذ كل ${med.interval} ساعة',
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
