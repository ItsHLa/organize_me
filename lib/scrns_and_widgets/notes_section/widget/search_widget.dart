import 'package:easy_search_bar/easy_search_bar.dart';
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
    return TextField(
      onSubmitted: (value) {
        setState(() {
          search = value;
        });
      },
        decoration: InputDecoration(
          suffix:const IconButton(
            onPressed: null ,
            icon:  Icon(Icons.search),
          ),
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black12),
          ),
        )
    );

  }
}
/*
*
*
*  Expanded(child: TextField(
      onSubmitted: (value) {
        setState(() {
          search = value;
        });
      },
    ));
* */