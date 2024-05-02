import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../services/functionality.dart';

part 'customize_state.dart';

class CustomizeCubit extends Cubit<CustomizeState> {
  CustomizeCubit()
      : super(CustomizeInitial(
            numMeds: true,
            bill: true,
            darkMode: false,
            taskNotes: true,
            pages: getPages(true, true, true),
            tabs: getTabs(true, true, true)));

  void getAllCustomization() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var taskNNotes = prefs.getBool(taskNotesKey)!;
    var bill = prefs.getBool(billsKey)!;
    var medsNDocs = prefs.getBool(medsAndDocsKey)!;
    List oldPages = getPages(taskNNotes, bill, medsNDocs);
    List<TabItem> oldTabs = getTabs(taskNNotes, bill, medsNDocs);
    emit(Customize(
      pages: oldPages,
      tabs: oldTabs,
      darkMode: prefs.getBool('darkMode') ?? false,
      taskNotes: taskNNotes,
      bill: bill,
      numMeds: medsNDocs,
    ));
  }

  void darkModeIsOn(bool darKMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', darKMode);
    var taskNNotes = prefs.getBool(taskNotesKey)!;
    var bill = prefs.getBool(billsKey)!;
    var medsNDocs = prefs.getBool(medsAndDocsKey)!;
    List pages = getPages(taskNNotes, bill, medsNDocs);
    List<TabItem> tabs = getTabs(taskNNotes, bill, medsNDocs);

    emit(Customize(
        tabs: tabs,
        pages: pages,
        darkMode: darKMode,
        taskNotes: taskNNotes,
        bill: bill,
        numMeds: medsNDocs));
  }

  void taskAndNotes(bool taskNotesOption) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var taskNNotes = prefs.getBool(taskNotesKey)!;
    var bill = prefs.getBool(billsKey)!;
    var medsNDocs = prefs.getBool(medsAndDocsKey)!;
    List oldPages = getPages(taskNNotes, bill, medsNDocs);
    List<TabItem> oldTabs = getTabs(taskNNotes, bill, medsNDocs);
    if (bill || medsNDocs) {
      prefs.setBool(taskNotesKey, taskNotesOption);
      List pages = getPages(taskNotesOption, bill, medsNDocs);
      List<TabItem> tabs = getTabs(
        taskNotesOption,
        bill,
        medsNDocs,
      );
      emit(Customize(
          pages: pages,
          tabs: tabs,
          darkMode: prefs.getBool('darkMode')!,
          taskNotes: taskNotesOption,
          bill: bill,
          numMeds: medsNDocs));
    } else {
      emit(CustomizeFailed(
          msg: 'عذرا لا يمكن تعديل',
          pages: oldPages,
          tabs: oldTabs,
          darkMode: prefs.getBool('darkMode')!,
          taskNotes: taskNNotes,
          bill: bill,
          numMeds: medsNDocs));
    }
  }

  void billPage(bool billOption) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var taskNNotes = prefs.getBool(taskNotesKey)!;
    var bill = prefs.getBool(billsKey)!;
    var medsNDocs = prefs.getBool(medsAndDocsKey)!;
    List oldPages = getPages(taskNNotes, bill, medsNDocs);
    List<TabItem> oldTabs = getTabs(taskNNotes, bill, medsNDocs);
    if (taskNNotes || medsNDocs) {
      prefs.setBool(billsKey, billOption);
      List pages = getPages(taskNNotes, billOption, medsNDocs);
      List<TabItem> tabs = getTabs(taskNNotes, billOption, medsNDocs);
      emit(Customize(
          tabs: tabs,
          pages: pages,
          darkMode: prefs.getBool('darkMode')!,
          taskNotes: taskNNotes,
          bill: billOption,
          numMeds: medsNDocs));
    } else {
      emit(CustomizeFailed(
          msg: 'عذرا لا يمكن تعديل',
          tabs: oldTabs,
          darkMode: prefs.getBool('darkMode')!,
          taskNotes: taskNNotes,
          bill: bill,
          numMeds: medsNDocs,
          pages: oldPages));
    }
  }

  void docsAndMedsPage(bool numMedsOption) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var taskNNotes = prefs.getBool(taskNotesKey)!;
    var bill = prefs.getBool(billsKey)!;
    var medsNDocs = prefs.getBool(medsAndDocsKey)!;
    List oldPages = getPages(taskNNotes, bill, medsNDocs);
    List<TabItem> oldTabs = getTabs(taskNNotes, bill, medsNDocs);
    if (taskNNotes || bill) {
      prefs.setBool(medsAndDocsKey, numMedsOption);
      List pages = getPages(taskNNotes, bill, numMedsOption);
      List<TabItem> tabs = getTabs(taskNNotes, bill, numMedsOption);
      emit(Customize(
          pages: pages,
          tabs: tabs,
          darkMode: prefs.getBool('darkMode')!,
          taskNotes: taskNNotes,
          bill: bill,
          numMeds: numMedsOption));
    } else {
      emit(CustomizeFailed(
          msg: 'عذرا لا يمكن تعديل',
          pages: oldPages,
          tabs: oldTabs,
          darkMode: prefs.getBool('darkMode')!,
          taskNotes: taskNNotes,
          bill: bill,
          numMeds: medsNDocs));
    }
  }
}