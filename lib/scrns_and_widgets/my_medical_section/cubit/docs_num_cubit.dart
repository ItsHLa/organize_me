import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/scrns_and_widgets/my_medical_section/models/doctors_contacts.dart';

part 'docs_num_state.dart';

class DocsNumCubit extends Cubit<DocsNumState> {
  List<DoctorsContacts> contacts = [];
  DocsNumCubit() : super(const DocsNumInitial(docsNumber: []));

  void addPhoneNumber(String name, String phoneNumber) async {
    try {
      Map docConMap = await DoctorsContacts.addContact(name, phoneNumber);
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
      for (DoctorsContacts c in contacts) {
        if (c.id == id) {
          contacts.remove(c);
          break;
        }
      }
      emit(DeleteDocsNumSuccess(docsNumber: contacts));
    } catch (e) {
      emit(DeleteDocsNumFailed('تعذر حذف جهة الاتصال', docsNumber: contacts));
    }
  }

  void call() {
    // we will use uel_lancher here
  }
}
