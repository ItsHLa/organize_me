import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'icon_button.dart';
import 'input.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo,
      child: Padding(
        padding: const EdgeInsets.all( 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  child:  Text('Note Name' , style: TextStyle(fontSize: 15),),)
               ,

                Spacer(),
                Row(
                  children: [
                    IconButtonCustom(
                        icon: Icons.edit,
                        logic: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => const Input(
                                title: 'عنوان الملاحظة',
                                content: 'الوصف',
                                action: 'تعديل الملاحظة ',
                                icon: Icons.edit,
                              ));
                        }),
                    IconButtonCustom(
                        logic: () {
                          showDialog(
                              context: context,
                              builder: (context) => const AlterDialogCustom());
                        },
                        icon: Icons.delete_outline)
                  ],
                )
              ],
            ),
            const Divider(),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text('ssjisjvincjnvnfubvfubufbudfbdufbuidfiubufuvbuifbvuifbsvsivn'),),
            const Row(
             children: [
               Spacer(),
               Padding(
                 padding: EdgeInsets.only(bottom: 8 , right: 8),
                 child: Text('25/3/2024' , style: TextStyle(fontSize: 12),),
               )
             ],
            )
          ],
        ),
      ),
    );





  }
}

class AlterDialogCustom extends StatefulWidget {
  const AlterDialogCustom({super.key});
  @override
  State<AlterDialogCustom> createState() => _AlterDialogCustomState();
}

class _AlterDialogCustomState extends State<AlterDialogCustom> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('هل انت متأكد من حذف هذه المهمة ؟', textAlign: TextAlign.center,),
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: const EdgeInsets.all(30),
      contentTextStyle: const TextStyle(fontSize: 15),
      actions: [
        ElevatedButton(onPressed: () {}, child: const Text('نعم')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('لا')),
      ],
    );
  }
}
