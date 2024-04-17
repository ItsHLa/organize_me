import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/home_page.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/bloc/notes_bloc.dart';
import 'package:organize_me/services/android_alarm_manager.dart';
import 'package:organize_me/services/local_notification_service/local_notification.dart';
import 'package:organize_me/services/telephony_service.dart';
import 'package:organize_me/services/work_manager_service/medicien_work_manager.dart';

@pragma('vm:entry-point')
void billCallBack(int id) {
  LocalNotificationService.showSimpleMonthlyBillNotification(id: id);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait(
      [LocalNotificationService.initi(), AndroidAlarmManager.initialize()]);
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
    MyAlarm.showBillNotificationInterval(id: 0, callback: billCallBack);
    DatabaseHelper.intialDb();
    super.initState();
    MedicineAlarm.askForAlarmPermission();
    TelephonyService.askForPermission();
    TelephonyService.listenForIncomingSms();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DarkModeCubit>(
      create: (context) => DarkModeCubit(),
      child: BlocBuilder<DarkModeCubit, DarkModeState>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData(brightness: Brightness.dark),
              theme: ThemeData(
                brightness:
                state is DarkModeOn ? Brightness.dark : Brightness.light,
              ),
              home: const HomePage());
        },
      ),
    );
  }
}
