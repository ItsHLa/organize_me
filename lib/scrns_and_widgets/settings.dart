import 'package:flutter/material.dart';

import '../constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool nightModeOn = false;
  bool powerSavingMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SettingsItem(
            icon: Icons.wb_sunny_outlined,
            title: 'وضع ليلي',
            color: yellow,
            value: nightModeOn,
            onChange: (value) {
              setState(() {
                nightModeOn = value;
              });
            },
          ),
          SettingsItem(
              icon: Icons.energy_savings_leaf_outlined,
              title: 'وضع توفير الطاقة',
              color: green,
              value: powerSavingMode,
              onChange: (value) {
                setState(() {
                  powerSavingMode = value;
                });
              })
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      this.onChange,
      required this.value,
      required this.title,
      required this.icon,
      required this.color});

  final void Function(bool)? onChange;

  final bool value;
  final String title;

  final IconData icon;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        value: value,
        onChanged: onChange,
        title: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(title),
            ),
            //energy_savings_leaf_outlined
          ],
        ));
  }
}
