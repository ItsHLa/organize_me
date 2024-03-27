import 'package:flutter/material.dart';

import '../widget/icon_button.dart';
import '../widget/input.dart';
import '../widget/task_item.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(9.0),
        child: Card(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        'Note Name',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    const Spacer(),
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
                                  builder: (context) =>
                                      const AlterDialogCustom());
                            },
                            icon: Icons.delete_outline)
                      ],
                    )
                  ],
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: const Text(
                      'ssjisjvincjnvnfubvfubufbudfbdufbuidfiubufuvbuifbvuifbsvsivn'),
                ),
                const Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8, right: 8),
                      child: Text(
                        '25/3/2024',
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
