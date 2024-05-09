import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/doctors_contacts.dart';

part 'docs_num_state.dart';

class DocsNumCubit extends Cubit<DocsNumState> {
  List<DoctorsContacts> contacts = [];

  DocsNumCubit() : super(const DocsNumInitial(docsNumber: []));

  void addPhoneNumber(
      String name, String phoneNumber, String specialist, String clinic) async {
    try {
      Map docConMap = await DoctorsContacts.addContact(
          name, phoneNumber, clinic, specialist);
      contacts.add(DoctorsContacts.fromMap(docConMap));
      emit(AddDocsNumSuccess(docsNumber: contacts));
    } catch (e) {
      emit(AddDocsNumFailed('تعذر إدخال جهة الاتصال', docsNumber: contacts));
    }
  }

  void editPhoneNumber(int contactId, String name, String phoneNumber) async {
    try {
      Map docConMap = await DoctorsContacts.editContact(
        contactId,
        newName: name,
        newPhone: phoneNumber,
      );
      for (DoctorsContacts c in contacts) {
        if (c.id == contactId) {
          int i = contacts.indexOf(c);
          contacts[i] = DoctorsContacts.fromMap(docConMap);
          break;
        }
      }
      emit(AddDocsNumSuccess(docsNumber: contacts));
    } catch (e) {
      emit(AddDocsNumFailed('تعذر تعديل جهة الاتصال', docsNumber: contacts));
    }
  }

  void deletePhoneNumber(int id) async {
    try {
      await DoctorsContacts.deleteContact(id);
      contacts.remove(contacts.singleWhere((con) => con.id == id));
      emit(DeleteDocsNumSuccess(docsNumber: contacts));
    } catch (e) {
      emit(DeleteDocsNumFailed('تعذر حذف جهة الاتصال', docsNumber: contacts));
    }
  }

  void loadDocsNumbers() async {
    emit(const DocsNumLoadingData(docsNumber: []));
    try {
      await DoctorsContacts.getAllContacts().then(
        (value) {
          contacts = value;
        },
      );
      emit(DocsNumLoaded(docsNumber: contacts));
    } catch (e) {
      emit(const DocsNumLoadingData(docsNumber: []));
    }
  }

  void call(String phoneNumber) async {
    Uri syriatelCash = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(syriatelCash);
  }
}
