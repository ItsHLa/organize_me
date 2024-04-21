import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../my_list_view.dart';
import '../cubit/docs_num_cubit.dart';
import '../edit_phone_num.dart';
import '../models/doctors_contacts.dart';
import '../phone_details.dart';
import 'docs_number_item.dart';

class DocsNumbersListView extends StatelessWidget {
  const DocsNumbersListView({super.key, required this.contacts});

  final List<DoctorsContacts> contacts;

  @override
  Widget build(BuildContext context) {
    return MyListView(
      dataList: contacts,
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return DocsNumber(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (newcontext) => BlocProvider<DocsNumCubit>.value(
                      value: BlocProvider.of(context),
                      child: ContactDetails(
                        onPressedDelete: () {
                          BlocProvider.of<DocsNumCubit>(context)
                              .deletePhoneNumber(contacts[index].id);
                          Navigator.of(context).pop();
                        },
                        onPressedEdit: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (modalcontext) {
                                return BlocProvider<DocsNumCubit>.value(
                                  value: BlocProvider.of(context),
                                  child:
                                      EditPhoneNumber(contact: contacts[index]),
                                );
                              });
                        },
                        idx: index,
                        contact: contacts[index],
                      ),
                    )));
          },
          docsName: contacts[index].name,
          phoneNumber: contacts[index].phone,
          onPressedCall: () {
            BlocProvider.of<DocsNumCubit>(context).call();
          },
        );
      },
    );
  }
}
