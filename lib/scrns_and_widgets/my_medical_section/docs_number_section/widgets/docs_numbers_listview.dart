import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../my_list_view.dart';
import '../cubit/docs_num_cubit.dart';
import '../edit_phone_num.dart';
import '../models/doctors_contacts.dart';
import '../phone_details.dart';
import 'docs_number_item.dart';

class DocsNumbersListView extends StatefulWidget {
  const DocsNumbersListView({super.key, required this.contacts});

  final List<DoctorsContacts> contacts;

  @override
  State<DocsNumbersListView> createState() => _DocsNumbersListViewState();
}

class _DocsNumbersListViewState extends State<DocsNumbersListView> {
  @override
  Widget build(BuildContext context) {
    return MyListView(
      dataList: widget.contacts,
      itemCount: widget.contacts.length,
      itemBuilder: (context, index) {
        return DocsNumber(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (newcontext) => BlocProvider<DocsNumCubit>.value(
                      value: BlocProvider.of(context),
                      child: ContactDetails(
                        onPressedEdit: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (modalcontext) {
                                return BlocProvider<DocsNumCubit>.value(
                                  value: BlocProvider.of(context),
                                  child: EditPhoneNumber(
                                      contact: widget.contacts[index]),
                                );
                              });
                        },
                        idx: index,
                        contact: widget.contacts[index],
                      ),
                    )));
          },
          docsName: widget.contacts[index].name,
          spec: widget.contacts[index].specialist,
          onPressedCall: () {
            BlocProvider.of<DocsNumCubit>(context)
                .call(widget.contacts[index].phone);
          },
        );
      },
    );
  }
}
