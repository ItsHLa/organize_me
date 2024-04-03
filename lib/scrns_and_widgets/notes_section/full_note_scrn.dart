import 'package:flutter/material.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/Note.dart';

import 'widget/icon_button.dart';
import 'widget/input.dart';
import 'widget/note_item.dart';

class NotePage extends StatelessWidget {
  final Note note;
  const NotePage({
    super.key,
    required this.note,
  });

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
                      child: Text(
                        note.title,
                        style: const TextStyle(fontSize: 15),
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
                              ),
                            );
                          },
                        ),
                        IconButtonCustom(
                          logic: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlterDialogCustom(
                                noteId: note.id,
                              ),
                            );
                          },
                          icon: Icons.delete_outline,
                        )
                      ],
                    )
                  ],
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    note.content,
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        right: 8,
                      ),
                      child: Text(
                        note.date,
                        style: const TextStyle(fontSize: 12),
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
