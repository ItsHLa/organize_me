import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/bills_view.dart';
import 'package:organize_me/scrns_and_widgets/bill_section/cubit/bill_cubit.dart';
import 'package:organize_me/scrns_and_widgets/icon_form.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/cubit/medicien_cubit.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/medicien_section/meds_page.dart';
import 'package:organize_me/scrns_and_widgets/notes_section/note_view.dart';
import 'package:organize_me/scrns_and_widgets/settings.dart';
import 'package:organize_me/scrns_and_widgets/task_section/cubit/task_cubit.dart';
import 'package:organize_me/scrns_and_widgets/task_section/task_view.dart';

/////////////////////////////////////// notifications constants//////////////////////////////
const taskTag = 'taskTag';
const medicineTag = 'medicineTag';
const billTag = 'billTag';

const String billChannel = 'bill_channel';
const String medicineChannel = 'medicine_channel';
const String taskChannel = 'task_channel';

const String taskChannelName = 'taskChannelName';
const String medicineChannelName = 'medicineChannelName';
const String billChannelName = 'billChannelName';

/////////////////////////////////////pages//////////////////////////////////////////
Widget settings = const Settings();
Widget taskPage = BlocProvider(
  create: (context) => TaskCubit(),
  child: const DayCalendar(),
);

Widget notesPage = const NoteView();

//Widget docsNumPage = BlocProvider(
//  create: (context) => DocsNumCubit(), child: const MedsAndDocs());

Widget medsPage = BlocProvider<MedicineCubit>(
  create: (context) => MedicineCubit(),
  child: const MedsPage(),
);

Widget billsPage = BlocProvider(
  create: (context) => BillCubit(),
  child: const MyBills(),
);
//////////////////////////////customize constants///////////////////////////////////

String taskNotesKey = 'taskNotes';
String billsKey = 'bill';
String medsAndDocsKey = 'numMeds';

////////////////////////////////////////TaskIcons///////////////////////////////////////////////////
Icon taskComplete = const Icon(
  Icons.task_alt_outlined,
  size: 30,
);
Icon taskOngoing = const Icon(
  Icons.pause_circle_outline_outlined,
  size: 30,
);
Icon taskPending = const Icon(
  Icons.not_started_outlined,
  size: 30,
);
/////////////////////////////////////////////darkModeIcons///////////////////////////////////////////
const Icon darkModeOn = Icon(Icons.wb_sunny_outlined);
const Icon darkModeOff = Icon(Icons.nightlight_outlined);
/////////////////////////////////BillIcons////////////////////////////////////////////////
Widget waterBill = const IconForm(
    child: Icon(
  Icons.water_drop,
  color: Color.fromRGBO(7, 144, 166, 1),
));
Widget electricBill = const IconForm(
    child: Icon(
  Icons.electric_bolt,
  color: Color.fromRGBO(219, 200, 109, 1),
));
Widget telecomBill = const IconForm(
    child: Icon(
  Icons.call_end,
  color: Color.fromRGBO(109, 124, 65, 1),
));

///////////////////////////Colors //////////////////////////////////////////////
const Color grey = Color(0xFFc9c0c7);
Color deepPurple = Colors.deepPurple.shade400;
Color softPurple = Colors.deepPurple.shade300;
const white = Colors.white54;
const Color verySoftDarkBlue = Color(0xFF20abb9);
const Color black = Color(0xFF222831);
const Color darkTheme = Color(0xFF121212);
const Color blue = Color.fromRGBO(7, 144, 166, 1);
const Color red = Color.fromRGBO(194, 100, 101, 1);
const Color yellow = Color.fromRGBO(219, 200, 109, 1);
const Color green = Color.fromRGBO(109, 124, 65, 1);

//////////////////////////////////Regex//////////////////////////////////////////
RegExp electricRegex = RegExp(
    r'\D+(\d+\.?\d*)\D+الكهرباء\D+(\d+\.?\d*)\D+(\d+)\D+(\d{2}/\d{2}/\d{4} \d{2}:\d{2})\D+: ([\u0621-\u064A]+)\D+(\d+)\D+(\d+)\D+(s\d+)');

Map<String, int> electricRegexGroups = {
  'payment amount': 1,
  'commission amount': 2,
  'invoice number': 3,
  'date': 4,
  'gov': 5,
  'billing number': 6,
  'subscription number': 7,
  'operation number': 8
};

RegExp waterRegex = RegExp(
    r'\D+(\d+\.?\d*)\D+المياه\D+(\d+\.?\d*)\D+(\d+_\d+)\D+(\d{2}/\d{2}/\d{4} \d{2}:\d{2})\D+: ([\u0621-\u064A]+)\D+(\d+)\D+(\d+)\D+(s\d+)');

Map<String, int> waterRegexGroups = {
  'payment amount': 1,
  'commission amount': 2,
  'receipt number': 3,
  'date': 4,
  'gov': 5,
  'barcode number': 6,
  'counter number': 7,
  'operation number': 8
};

RegExp telecomRegex = RegExp(
    r'\D+(\d+\.?\d*)\D+السورية للاتصالات\D+(\d+\.?\d*)\D+(\d+)\D+(\d{2}/\d{2}/\d{4} \d{2}:\d{2})\Dرقم الهاتف الثابت/ البريد الإلكتروني: (\S+@\S+\.\S+|\d+)\D+(s\d+)');

Map<String, int> telecomRegexGroups = {
  'payment amount': 1,
  'commission amount': 2,
  'invoice number': 3,
  'date': 4,
  'phone number/email': 5,
  'operation number': 6
};

Widget noBillsToShow = const Center(
  child: Text(
    'لا يوجد فواتير لعرضها',
    style: TextStyle(
      fontSize: 20,
    ),
  ),
);
