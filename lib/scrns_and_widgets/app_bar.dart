import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/dark_mode_cubit/dark_mode_cubit.dart';

import '../constants.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'OrganizeMe',
        style: TextStyle(color: appColorTheme),
      ),
      actions: [
        BlocBuilder<DarkModeCubit, DarkModeState>(
          builder: (context, state) {
            print(state.on);
            return IconButton(
              onPressed: () {
                BlocProvider.of<DarkModeCubit>(context).darkModeIsOn();
              },
              icon: state.on ? darkModeOn : darkModeOff,
            );
          },
        ),
        const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.energy_savings_leaf_outlined,
          ),
        )
      ],
    );
  }
}

/*AppBar(
          title: Text(
            'Organize Me',
            style: TextStyle(color: appColorTheme),
          ),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(Icons.settings));
            }),
          ],
        )*/