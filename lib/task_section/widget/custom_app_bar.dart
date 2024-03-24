import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
        child: Row(children: [
          const SizedBox(
            width: 5,
          ),
          const Icon(
            Icons.checklist_sharp,
            size: 28,
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
            'Tasks',
            style: TextStyle(fontSize: 25),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.wb_sunny_outlined)),
          const IconButton(onPressed: null, icon: Icon(Icons.search))
        ]));
  }
}
