import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

part 'customize_state.dart';

class CustomizeCubit extends Cubit<CustomizeState> {
  CustomizeCubit()
      : super(CustomizeInitial(
            numMeds: true, taskNotes: true, bill: true, darkMode: false));
  bool taskNotes = true;
  bool bill = true;
  bool numMeds = true;
  bool darkMode = false;

  void darkModeIsOn() {
    darkMode = !darkMode;
    if (darkMode) {
      emit(CustomizeDarkModeOn(
          darkMode: darkMode,
          numMeds: numMeds,
          taskNotes: taskNotes,
          bill: bill));
    } else {
      emit(CustomizeDarkModeOff(
          darkMode: darkMode,
          numMeds: numMeds,
          taskNotes: taskNotes,
          bill: bill));
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

  void taskAndNotes() {
    taskNotes = !taskNotes;
    if (taskNotes) {
      addToList(element: taskPage, list: pages);
      addToList(element: notesPage, list: pages);
      addToList(element: taskTab, list: tabsItem);
      addToList(element: notesTab, list: tabsItem);
    } else {
      removeFromList(element: taskPage, list: pages);
      removeFromList(element: notesPage, list: pages);
      removeFromList(element: taskTab, list: tabsItem);
      removeFromList(element: notesTab, list: tabsItem);
    }
  }

  void billPage() {
    bill = !bill;
    if (bill) {
      addToList(element: billsPage, list: pages);
      addToList(element: billsTab, list: tabsItem);
    } else {
      removeFromList(element: billsPage, list: pages);
      removeFromList(element: billsTab, list: tabsItem);
    }
  }

  void docsAndMedsPage() {
    numMeds = !numMeds;
    if (numMeds) {
      addToList(element: docsNumPage, list: pages);
      addToList(element: docsNumTab, list: tabsItem);
      addToList(element: medsPage, list: pages);
      addToList(element: medsTab, list: tabsItem);
    } else if (numMeds) {
      removeFromList(element: docsNumPage, list: pages);
      removeFromList(element: docsNumTab, list: tabsItem);
      removeFromList(element: medsPage, list: pages);
      removeFromList(element: medsTab, list: tabsItem);
    }
  }

  void customizeTasks() {
    try {
      taskAndNotes();
      emit(CustomizeBottomNavigationBar(
          darkMode: darkMode,
          numMeds: numMeds,
          taskNotes: taskNotes,
          bill: bill));
    } catch (e) {}
  }

  void customizeBills() {
    try {
      billPage();
      emit(CustomizeBottomNavigationBar(
          darkMode: darkMode,
          numMeds: numMeds,
          taskNotes: taskNotes,
          bill: bill));
    } catch (e) {}
  }

  void customizeDocs() {
    try {
      docsAndMedsPage();
      emit(CustomizeBottomNavigationBar(
          darkMode: darkMode,
          numMeds: numMeds,
          taskNotes: taskNotes,
          bill: bill));
    } catch (e) {}
  }
}
