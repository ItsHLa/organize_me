/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../customize_app_cubit/customize_cubit.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool darkMode = false;
  bool taskNotes = true;
  bool bill = true;
  bool docsAndMeds = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomizeCubit, CustomizeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Drawer(
          child: ListView(
            children: [
              Option(
                value: state.darkMode,
                title: 'وضع ليلي',
                onChanged: (value) {
                  BlocProvider.of<CustomizeCubit>(context).darkModeIsOn(value);
                },
              ),
              const Option(
                value: true,
                title: 'تخزين احتياطي',
                onChanged: null,
              ),
              const Option(
                value: true,
                title: 'ذكرني بفواتيري',
                onChanged: null,
              )
            ],
          ),
        );
      },
    );
  }
}

class Option extends StatelessWidget {
  const Option(
      {super.key, required this.value, this.onChanged, required this.title});

  final bool value;
  final void Function(bool)? onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text(title), value: value, onChanged: onChanged);
  }
}
*/
