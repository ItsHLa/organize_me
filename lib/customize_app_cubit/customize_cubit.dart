import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

part 'customize_state.dart';

class CustomizeCubit extends Cubit<CustomizeState> {
  CustomizeCubit()
      : super(const CustomizeInitial(
            taskNotes: true, bill: true, numMeds: true, darkMode: true));
  bool taskNotes = true;
  bool bill = true;
  bool numMeds = true;
  bool darkMode = false;

  void darkModeIsOn() {
    darkMode = !darkMode;
    if (darkMode) {
      emit(CustomizeDarkModeOn(
          darkMode: darkMode,
          taskNotes: taskNotes,
          bill: bill,
          numMeds: numMeds));
    } else {
      emit(CustomizeDarkModeOff(
          darkMode: darkMode,
          taskNotes: taskNotes,
          bill: bill,
          numMeds: numMeds));
    }
  }

  //List pages = [];
  List<TabItem> tabsItem = [taskTab, notesTab, billsTab, docsNumTab, medsTab];

  List pages = [taskPage, notesPage, billsPage, docsNumPage, medsPage];

  List getPages() {
    return pages;
  }

  List<TabItem> getTabs() {
    return tabsItem;
  }

  void addToList({required dynamic element, required List list}) {
    if (!list.contains(element)) {
      list.add(element);
    }
  }

  void removeFromList({required dynamic element, required List list}) {
    if (list.contains(element)) {
      list.remove(element);
    }
  }

  void taskAndNotes({required bool tasksAndNotes}) {
    taskNotes = tasksAndNotes;
    if (!tasksAndNotes) {
      removeFromList(element: taskPage, list: pages);
      removeFromList(element: notesPage, list: pages);
      removeFromList(element: taskTab, list: tabsItem);
      removeFromList(element: notesTab, list: tabsItem);
    } else if (tasksAndNotes) {
      addToList(element: taskPage, list: pages);
      addToList(element: notesPage, list: pages);
      addToList(element: taskTab, list: tabsItem);
      addToList(element: notesTab, list: tabsItem);
    }
  }

  void billPage({required bool bills}) {
    bill = bills;
    if (!bills) {
      removeFromList(element: billsPage, list: pages);
      removeFromList(element: billsTab, list: tabsItem);
    } else if (bills && !pages.contains(billsPage)) {
      addToList(element: billsPage, list: pages);
      addToList(element: billsTab, list: tabsItem);
    }
  }

  void docsAndMedsPage({required bool docsAndNumber}) {
    numMeds = docsAndNumber;
    if (!docsAndNumber) {
      removeFromList(element: docsNumPage, list: pages);
      removeFromList(element: docsNumTab, list: tabsItem);
      removeFromList(element: medsPage, list: pages);
      removeFromList(element: medsTab, list: tabsItem);
    } else if (docsAndNumber) {
      addToList(element: docsNumPage, list: pages);
      addToList(element: docsNumTab, list: tabsItem);
      addToList(element: medsPage, list: pages);
      addToList(element: medsTab, list: tabsItem);
    }
  }

  void customize(
      {required bool tasksAndNotes,
      required bool bills,
      required bool docsAndNumber}) {
    taskAndNotes(tasksAndNotes: tasksAndNotes);
    billPage(bills: bills);
    docsAndMedsPage(docsAndNumber: docsAndNumber);
    emit(CustomizeBottomNavigationBar(
        taskNotes: taskNotes,
        bill: bill,
        numMeds: numMeds,
        darkMode: darkMode));
  }
}
