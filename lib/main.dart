import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:organize_me/home_page.dart';
import 'package:organize_me/services/functionality.dart';
import 'package:organize_me/services/local_notification.dart';
import 'package:organize_me/services/telephony_service.dart';
import 'package:organize_me/user_cubit/user_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

import 'database/db.dart';
import 'services/work_manager_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await requestPermission(Permission.);

  await requestPermission(Permission.phone);
  await requestPermission(Permission.sms);
  await requestPermission(Permission.notification);
  await Future.wait(
    [
      DatabaseHelper.intialDb(),
      LocalNotificationService.initi(),
      WorkManagerService().init(),
    ],
  );
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
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => DarkModeCubit(),
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
    TelephonyService.listenForIncomingSms();
    BlocProvider.of<UserCubit>(context).checkIfSigned();
    super.initState();
  }

  bool signed = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DarkModeCubit>(context).getDarkMode();
    return BlocBuilder<DarkModeCubit, DarkModeState>(
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: state.on ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark(),
            theme: state.on ? ThemeData.dark() : ThemeData.light(),
            home: BlocListener<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is CheckIfSigned) {
                    signed = state.signed;
                  }
                },
                child: HomePage()
                //signed ? const HomePage() : const Register(),
                ));
      },
    );
  }
}
