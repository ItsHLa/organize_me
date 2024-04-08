import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/widgets/docs_numbers_listview.dart';

class MedsAndDocs extends StatelessWidget {
  const MedsAndDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.drag_handle,
        children: [
          SpeedDialChild(
            shape: const StadiumBorder(),
            onTap: null,
            child: const Icon(Icons.medication),
          ),
          SpeedDialChild(
            shape: const StadiumBorder(),
            onTap: null,
            child: const Icon(Icons.add_call),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: DocsNumbers(),
          ),
        ],
      ),
    );
  }
}
