import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:organize_me/constants.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/docs_number_section/docs_numbers_list.dart';

import 'add_phone_num.dart';
import 'cubit/docs_num_cubit.dart';

class MedsAndDocs extends StatelessWidget {
  const MedsAndDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اطبائي'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColorTheme,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_call),
        onPressed: () async {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (newcontext) => BlocProvider<DocsNumCubit>.value(
              value: BlocProvider.of(context),
              child: const AddPhoneNum(),
            ),
          );
        },
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

class MyFabButtons extends StatelessWidget {
  const MyFabButtons(
      {super.key, required this.children, this.onPress, required this.icon});

  final List<SpeedDialChild> children;
  final void Function()? onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      shape: const StadiumBorder(),
      label: Icon(icon),
      onPress: onPress,
      children: children,
    );
  }
}

/*
*
* SpeedDialChild(
            shape: const StadiumBorder(),
            child: const Icon(Icons.book),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Altibbi(),
              ));
            },
            /* onTap:() async {
    final Uri _url = Uri.parse();
    if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');}}*/
          ),
*
*
* */

/*floatingActionButton: MyFabButtons(
        icon: Icons.menu,
        children: [
          SpeedDialChild(
            shape: const StadiumBorder(),
            child: const ,
            onTap: () async {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (newcontext) => BlocProvider<DocsNumCubit>.value(
                  value: BlocProvider.of(context),
                  child: const AddPhoneNum(),
                ),
              );
            },
          ),
          SpeedDialChild(
            shape: const StadiumBorder(),
            child: const Icon(Icons.contacts),
            onTap:
          )
        ],
      ),*/