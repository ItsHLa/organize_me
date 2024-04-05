import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MedsAndDocs extends StatelessWidget {
  const MedsAndDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.drag_handle,
        children: [
          SpeedDialChild(
              shape: StadiumBorder(),
              onTap: null,
              child: Icon(Icons.medication)),
          SpeedDialChild(
              shape: StadiumBorder(), onTap: null, child: Icon(Icons.add_call)),
        ],
      ),
      body: Column(children: []),
    );
  }
}
