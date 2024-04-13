import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  const MyListView(
      {super.key,
      required this.dataList,
      required this.itemBuilder,
      required this.itemCount});

  final List dataList;

  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        itemBuilder: itemBuilder);
  }
}
