import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Card(
          child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(9),
              alignment: Alignment.center,
              child: const Text('event')),
          const Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.cancel_outlined))
        ],
      ));
    });
  }
}
