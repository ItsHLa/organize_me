import 'package:flutter/material.dart';

import '../constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool nightModeOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SwitchListTile(
              value: nightModeOn,
              onChanged: (value) {
                setState(() {
                  nightModeOn = value;
                });
              },
              title: const Row(
                children: [
                  Icon(
                    Icons.wb_sunny_outlined,
                    color: yellow,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('وضع ليلي'),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
