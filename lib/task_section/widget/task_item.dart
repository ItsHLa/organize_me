import 'package:flutter/material.dart';
import 'package:organize_me/task_section/scrns/full_note_scrn.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Column(
        children: [
          ListTile(
            // deleting on long press !!!!!!!!!!!!
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NotePage())),
            title: const Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Note Name',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Spacer()
                  ],
                ),
                Divider()
              ],
            ),
            subtitle: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                  'ssjisjvincjnvnfubvfubufbudfbdufbuidfiubufuvbuifbvuifbsvsifnbldfnbjdfjdnfbkfnbkfbdkfrnvsuefgufbusfubsrubsuduisdfuivfiudfvn'),
            ),
          ),
          const Row(
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 10, right: 10),
                child: Text(
                  '25/3/2024',
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          )
        ],
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
      content: const Text(
        'هل انت متأكد من حذف هذه المهمة ؟',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: const EdgeInsets.all(30),
      contentTextStyle: const TextStyle(fontSize: 15),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('نعم'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('لا'),
        ),
      ],
    );
  }
}
