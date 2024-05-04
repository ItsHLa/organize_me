/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/customize_app_cubit/customize_cubit.dart';

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
        BlocBuilder<CustomizeCubit, CustomizeState>(
          builder: (context, state) {
            return IconButton(
                onPressed: () {
                  // BlocProvider.of<CustomizeCubit>(context).darkModeIsOn();
                },
                icon: //state.darkMode ?
                    darkModeOn
                //: darkModeOff,
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
*/
