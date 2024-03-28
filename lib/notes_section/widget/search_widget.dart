import 'package:flutter/material.dart';

class MySearchWidget extends StatefulWidget {
  const MySearchWidget({super.key});

  @override
  State<MySearchWidget> createState() => _MySearchWidgetState();
}

class _MySearchWidgetState extends State<MySearchWidget> {

  late String search ;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: TextField(
      onSubmitted: (value) {
        setState(() {
          search = value;
        });
      },
    ));
  }
}
