import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.events, required this.date});

  final List<CalendarEventData<Object?>> events;

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          var current = events[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Row(
                  children: [
                    Spacer(),
                    IconButton(
                        onPressed: null, icon: Icon(Icons.cancel_outlined))
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(9),
                  child: Text(current.title),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text(' ${date.day} / ${date.month} / ${date.year} '),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        });
  }
}
