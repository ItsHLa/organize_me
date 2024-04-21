import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

part 'customize_state.dart';

class CustomizeCubit extends Cubit<CustomizeState> {
  CustomizeCubit() : super(CustomizeInitial());

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

  void bill({required bool bills}) {
    if (!bills) {
      removeFromList(element: billsPage, list: pages);
      removeFromList(element: billsTab, list: tabsItem);
    } else if (bills && !pages.contains(billsPage)) {
      addToList(element: billsPage, list: pages);
      addToList(element: billsTab, list: tabsItem);
    }
  }

  void docsAndMeds({required bool docsAndNumber}) {
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
    bill(bills: bills);
    docsAndMeds(docsAndNumber: docsAndNumber);
    emit(Customize());
  }
}
