import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return const Card(
          child: Row(
        children: [
          Text('event'),
          Spacer(),
          IconButton(onPressed: null, icon: Icon(Icons.cancel_outlined))
        ],
      ));
    });
  }
}
