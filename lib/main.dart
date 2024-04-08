import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:organize_me/database/db.dart';
import 'package:organize_me/scrns_and_widgets/drawer.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/bloc/notes_bloc.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/models/note.dart';
import 'package:organize_me/services/local_notification_service.dart';
import 'package:telephony/telephony.dart';

backgroundMessageHandler(SmsMessage message) async {
  Telephony.backgroundInstance.listenIncomingSms(
    onNewMessage: (message) {
      if (message.body!.contains('كهرباء')) {
        // add to database
        // set notification after 3 months
      }
      if (message.body!.contains('السورية للاتصالات ')) {
        // add to database
        // set notification after 3 months
      }
      if (message.body!.contains('فاتورة المياه')) {
        // add to database
        // set notification after 3 months
      }
      if (message.body!.contains('الغاز')) {
        // send notification
      }
      if (message.body!.contains(' بنزين من محطة')) {
        // send notification
      }
      if (message.body!.contains('خبز')) {
        // send notification
      }
    },
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.inite();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotesBloc()),
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
  void _getAllNotes() async {
    BlocProvider.of<NotesBloc>(context).notes = await Note.getAllNotes();
  }

  @override
  void initState() {
    DatabaseHelper.intialDb();
    _getAllNotes();
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
