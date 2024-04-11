import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/drawer.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/bloc/notes_bloc.dart';
import 'package:organize_me/services/local_notification_service/local_notification.dart';
import 'package:organize_me/services/work_manager_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // it will wait the largest time in its List
  // example :
  await Future.wait([
    LocalNotificationService.initi(), // wait 3s
    WorkManagerService().init()
  ]); // wait 7s
  // then it will wait for 7s
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DarkModeCubit>(
      create: (context) => DarkModeCubit(),
      child: BlocBuilder<DarkModeCubit, DarkModeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness:
                  state is DarkModeOn ? Brightness.dark : Brightness.light,
            ),
            home: const Scaffold(
              body: MDrawe(),
            ),
          );
        },
      ),
    );
  }
}
