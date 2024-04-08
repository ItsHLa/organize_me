import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/dark_mode_cubit/dark_mode_cubit.dart';

import '../constants.dart';

class MAppBar extends StatefulWidget {
  const MAppBar({super.key});

  @override
  State<MAppBar> createState() => _MAppBarState();
}

class _MAppBarState extends State<MAppBar> {
  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: const Text(
        'OrganizeMe',
        style: TextStyle(color: deepPurple),
      ),
      actions: [
        BlocBuilder<DarkModeCubit, DarkModeState>(
          builder: (context, state) {
            return IconButton(
                onPressed: () {
                  BlocProvider.of<DarkModeCubit>(context).darkModeIsOn();
                },
                icon: state.icon);
          },
        ),
        IconButton(
            onPressed: null, icon: Icon(Icons.energy_savings_leaf_outlined))
      ],
    );
  }
}
