import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:organize_me/scrns_and_widgets/floating_action_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';
import '../docs_number_section/altibbi.dart';
import 'add_medicien_screen.dart';
import 'cubit/medicien_cubit.dart';
import 'meds_list.dart';

class MedsPage extends StatelessWidget {
  const MedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFab(
        children: [
          SpeedDialChild(
              child: const Icon(Icons.medication),
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (newcontext) => BlocProvider<MedicineCubit>.value(
                    value: BlocProvider.of(context),
                    child: const AddMedsScreen(),
                  ),
                );
              }),
          SpeedDialChild(
              child: const Icon(Icons.contacts),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => docsNumPage));
              }),
          SpeedDialChild(
            shape: const StadiumBorder(),
            child: const Icon(Icons.book),
            onTap: () async {
              final Uri url = Uri.parse(
                  'https://altibbi.com/%D8%A7%D9%84%D8%AF%D9%84%D9%8A%D9%84-%D8%A7%D9%84%D8%B7%D8%A8%D9%8A/%D8%B3%D9%88%D8%B1%D9%8A%D8%A7');
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
              // Navigator.of(context).push(MaterialPageRoute(
              // builder: (context) => const Altibbi(),
              // ));
            },
            /* onTap:() async {
    final Uri _url = Uri.parse();
    if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');}}*/
          ),
        ],
      ),
      body: const MedsGrid(),
    );
  }
}
