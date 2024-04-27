import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/home_page.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/bloc/notes_bloc.dart';
import 'package:organize_me/services/local_notification.dart';
import 'package:organize_me/services/telephony_service.dart';

import 'customize_app_cubit/customize_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    LocalNotificationService.initi(),
    //  WorkManagerService().init()
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotesBloc(),
        ),
      ],
      child: const MaterialApp(
        home: OrganizeMe(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class OrganizeMe extends StatefulWidget {
  const OrganizeMe({super.key});

  @override
  State<OrganizeMe> createState() => _OrganizeMeState();
}

class _OrganizeMeState extends State<OrganizeMe> {
  @override
  void initState() {
    DatabaseHelper.intialDb();
    TelephonyService.askForPermission();
    TelephonyService.listenForIncomingSms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomizeCubit>(
      create: (context) => CustomizeCubit(),
      child: BlocBuilder<CustomizeCubit, CustomizeState>(
        builder: (context, state) {
          return MaterialApp(
              themeMode: ThemeMode.system,
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData(brightness: Brightness.dark),
              theme: ThemeData(
                brightness: state.darkMode ? Brightness.dark : Brightness.light,
              ),
              home: const HomePage());
        },
      ),
    );
  }
}
